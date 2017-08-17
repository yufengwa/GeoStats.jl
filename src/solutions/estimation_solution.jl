## Copyright (c) 2017, Júlio Hoffimann Mendes <juliohm@stanford.edu>
##
## Permission to use, copy, modify, and/or distribute this software for any
## purpose with or without fee is hereby granted, provided that the above
## copyright notice and this permission notice appear in all copies.
##
## THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
## WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
## MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
## ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
## WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
## ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
## OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.

"""
    EstimationSolution

A solution to a spatial estimation problem.
"""
struct EstimationSolution{D<:AbstractDomain} <: AbstractSolution
  domain::D
  mean::Dict{Symbol,Vector}
  variance::Dict{Symbol,Vector}
end

EstimationSolution(domain, mean, variance) =
  EstimationSolution{typeof(domain)}(domain, mean, variance)

function digest(solution::EstimationSolution{<:RegularGrid})
  # get the size of the grid
  sdomain = domain(solution)
  sz = size(sdomain)

  # solution variables
  variables = keys(solution.mean)

  # output dictionary
  digested = Dict{Symbol,Dict{Symbol,<:Array}}()
  for var in variables
    M = reshape(solution.mean[var], sz)
    V = reshape(solution.variance[var], sz)

    push!(digested, var => Dict(:mean => M, :variance => V))
  end

  digested
end