export singleton, set, card, fullset

# Set Manipulation
# function subsets(S)
#   if S == 0
#     return []
#   else
#     cum = [S]
#     for i = 0:(n-1)
#       if (S & (1 << i)) != 0
#         append!(cum, subsets(S $ (1 << i)))
#       end
#     end
#     return cum
#   end
# end
#
# function subsetsones(S)
#   ret = zeroentropy(N)
#   ret[subsets(S)] = 1
#   return ret
# end

function Base.setdiff(S::Unsigned, I::Unsigned)
  S & (~I)
end

# S ∪ T
function Base.union(S::Unsigned, T::Unsigned)
  S | T
end

# S ∩ T
function Base.intersect(S::Unsigned, T::Unsigned)
  S & T
end

# S ⊆ T
function issubset(S::Unsigned, T::Unsigned)
  Base.setdiff(S, T) == zero(S)
end

function singleton(i::Integer)
  0b1 << (i-1)
end

function fullset(n::Integer)
  (0x1 << n) - 0x1
end

function set(i::Integer)
  ret = 0b0
  while i > 0
    ret = union(ret, singleton(i % 10))
    i = div(i, 10)
  end
  ret
end
function set{S<:Integer}(I::AbstractArray{S})
  ret = 0b0
  for i in I
    ret = union(ret, singleton(i))
  end
  ret
end


function myin(i::Signed, I::Unsigned)
  (singleton(i) & I) != 0
end

function card(S::Unsigned)
  sum = 0
  while S > 0
    sum += S & 1
    S >>= 1
  end
  Signed(sum)
end

function mymap(map::Vector, S::Unsigned, n)
  T = 0x0
  for i in 1:n
    if myin(i, S)
      T = T ∪ singleton(map[i])
    end
  end
  T
end
