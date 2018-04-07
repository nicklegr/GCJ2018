require 'pp'

def ppd(*arg)
  if $DEBUG
    pp(*arg)
  end
end

def putsd(*arg)
  if $DEBUG
    puts(*arg)
  end
end

def parr(arr)
  puts arr.join(" ")
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

def filled(grid, cx, cy)
  for y in -1..1
    for x in -1..1
      px = cx + x
      py = cy + y
      raise if px <= 0 || px >= 1001
      raise if py <= 0 || py >= 1001
      return false if !grid[py][px]
    end
  end
  true
end

# main
t_start = Time.now

cases = readline().to_i

(1 .. cases).each do |case_index|
  # write your code here
  a = ri

  grid = Array.new(1001) do
    Array.new(1001) do
      false
    end
  end

  cx = 2
  cy = 2

  loop do
    # answer
    puts_sync "#{cx} #{cy}"

    # response
    rx, ry = ris
    if rx == -1 && ry == -1
      raise
    elsif rx == 0 && ry == 0
      break
    else
      grid[ry][rx] = true
      if filled(grid, cx, cy)
        cy += 3
      end
    end
  end

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
