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

def rot(x, y, t)
  x_ = x * Math::cos(t) - y * Math::sin(t)
  y_ = x * Math::sin(t) + y * Math::cos(t)
  [ x_, y_ ]
end

EPS = 10 ** -9

# main
t_start = Time.now

cases = readline().to_i

(1 .. cases).each do |case_index|
  # write your code here

  a = rf

  # theta = [0, pi/4]
  min_t = -Math::PI/4
  max_t = 0.0
  t = nil
  loop do
    t = (min_t + max_t) / 2
    x = 0.5 * Math.cos(t) - 0.5 * Math.sin(t)
    diff = x*2 - a

    if diff.abs <= EPS
      break
    elsif diff > 0
      min_t = t
    else
      max_t = t
    end
  end

ppd (t * 180 / Math::PI)

  x1, y1 = rot(-0.5, 0, t)
  x2, y2 = rot(0, 0.5, t)
  # raise if (Math.sqrt(x1**2 + y1**2) - 0.5).abs > 10 ** -6
  # raise if (Math.sqrt(x2**2 + y2**2) - 0.5).abs > 10 ** -6

  puts "Case ##{case_index}:"
  puts "#{x1} #{y1} 0"
  puts "#{x2} #{y2} 0"
  puts "0 0 0.5"

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
