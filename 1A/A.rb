require 'pp'

def ppd(*arg)
  if $DEBUG
    arg.each do |e|
      PP.pp(e, STDERR)
    end
  end
end

def putsd(*arg)
  if $DEBUG
    STDERR.puts(*arg)
  end
end

def parrd(arr)
  putsd arr.join(" ")
end

def ri
  readline.to_i
end

def ris
  readline.split.map do |e| e.to_i end
end

def rs
  readline.chomp
end

def rss
  readline.chomp.split
end

def rf
  readline.to_f
end

def rfs
  readline.split.map do |e| e.to_f end
end

def rws(count)
  words = []
  count.times do
    words << readline.chomp
  end
  words
end

def puts_sync(str)
  puts str
  STDOUT.flush
end

class Integer
  def popcount32
    bits = self
    bits = (bits & 0x55555555) + (bits >>  1 & 0x55555555)
    bits = (bits & 0x33333333) + (bits >>  2 & 0x33333333)
    bits = (bits & 0x0f0f0f0f) + (bits >>  4 & 0x0f0f0f0f)
    bits = (bits & 0x00ff00ff) + (bits >>  8 & 0x00ff00ff)
    return (bits & 0x0000ffff) + (bits >> 16 & 0x0000ffff)
  end

  def combination(k)
    self.factorial/(k.factorial*(self-k).factorial)
  end

  def permutation(k)
    self.factorial/(self-k).factorial
  end

  def factorial
    return 1 if self == 0
    (1..self).inject(:*)
  end
end

def solve()
  r, c, h, v = ris

  grid = rws(r)

  total = 0
  for y in 0..r-1
    for x in 0..c-1
      total += 1 if grid[y][x] == "@"
    end
  end

  return true if total == 0
  return false if total % (h+1) != 0
  return false if total / ((h+1) * (v+1)) != 0

  p_must = total / ((h+1) * (v+1))

  h_must = total / (h+1)

  h_cuts = []
  sum = 0

  for y in 0..r-1
    for x in 0..c-1
      sum += 1 if grid[y][x] == "@"
    end
    if sum == h_must
      h_cuts << x
      sum = 0
    end
  end

  return false if h_cuts.size != h
  return false if sum != h_must

  raise if h_cuts.uniq.size != h

  v_cuts = []
  p_sum = Array.new(h+1) { |i| 0 }
  for x in 0..c-1
    i = 0
    for y in 0..r-1
      if y <= h_cuts[i]
        p_sum[i] += 1
      else
        i += 1
        p_sum[i] += 1
      end
    end

    return false if p_sum.any? do |e|
      e > p_must
    end

    if p_sum.all?{|e| e == p_must}
      v_cuts << x
      p_sum = Array.new(h+1) { |j| 0 }
    end
  end

  return false if p_sum.any? do |e|
    e != p_must
  end

  return true
end

# main
t_start = Time.now

cases = readline().to_i

(1 .. cases).each do |case_index|
  answer = solve() ? "POSSIBLE" : "IMPOSSIBLE"

  puts "Case ##{case_index}: #{answer}"

  # progress
  trigger = 
    if cases >= 10
      case_index % (cases / 10) == 0
    else
      true
    end

  if trigger
    STDERR.puts("case #{case_index} / #{cases}, time: #{Time.now - t_start} s")
  end
end
