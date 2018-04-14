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

# main
t_start = Time.now

cases = readline().to_i

(1 .. cases).each do |case_index|
  c, r, h, v = ris

  grid = rws(c)

  ok = false
  # cut x -> [0..x]
  for y in 0..c-2
    for x in 0..r-2
      c1 = 0
      for j in 0..y
        for i in 0..x
          c1 += 1 if grid[j][i] == "@"
        end
      end

      c2 = 0
      for j in 0..y
        for i in x+1..r-1
          c2 += 1 if grid[j][i] == "@"
        end
      end

      c3 = 0
      for j in y+1..c-1
        for i in 0..x
          c3 += 1 if grid[j][i] == "@"
        end
      end

      c4 = 0
      for j in y+1..c-1
        for i in x+1..r-1
          c4 += 1 if grid[j][i] == "@"
        end
      end

      if c1 == c2 && c2 == c3 && c3 == c4
        ok = true
        break
      end
    end
  end

  answer = ok ? "POSSIBLE" : "IMPOSSIBLE"

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
