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
  n, l = ris
  words = rws(n)

  tbl = Array.new(l) do
    {}
  end

  for i in 1..l
    words.each do |w|
      sub = w[0, i]
      tbl[i-1][sub] = 1
    end
  end

  ans = ""
  ok = false
  for i in 0...l
    ok_in = false
    words.each do |w|
      can = ans + w[i]
      if !tbl[i].key?(can)
        ok = ok_in = true
        ans += w[i]
        break
      end
    end

    if !ok_in
      chrs = Hash.new(0)
      words.each do |e|
        chrs[e[i]] += 1
      end

      min_chr = nil
      min_cnt = nil

      chrs.each do |ch, cnt|
        if !min_cnt || cnt < min_cnt
          min_chr = ch
          min_cnt = cnt
        end
      end

      raise if !min_chr
      ans += min_chr
    end
  end

  answer = ok ? ans : "-"
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
