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
  r, b, c = ris
  m = []
  s = []
  p_ = []
  c.times do
    d = ris
    m << d[0]
    s << d[1]
    p_ << d[2]
  end

  min_t = 10 ** 20
  cashiers = (0...c).to_a
  cashiers.combination(r) do |cs|
    bs = Array.new(cs.size){|e| 0}
    bs[bs.size-1] = m[cs.last]

    loop do
      time = 0
      cs.each_with_index do |ci, ri|
        t = s[ci] * bs[ri] + p_[ci]
        time = t if t > time
      end
      min_t = time if time < min_t

      case bs.size
      when 1
        bs[0] = b
      when 2
        for i in 0..m[cs[0]]
          for j in 0..m[cs[1]]
            next if i+j != b
            bs = [i, j]




      i = bs.size-1
      loop do
        bs[i] -= 1
        if bs[i] < 0
          bs[i] = m[cs[i]]
          bs[i-1] -= 1


    end




  end



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
