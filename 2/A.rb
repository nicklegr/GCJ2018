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
  c = ri
  bs = ris

  needs = bs.dup
  to_idx = Array.new(c)

  if bs.first == 0 || bs.last == 0
    puts "Case ##{case_index}: IMPOSSIBLE"
    next
  end

  to = 0
  for i in 0...c
    while needs[to] == 0
      to += 1
    end
    to_idx[i] = to
    needs[to] -= 1
  end

# ppd to_idx

  grid = []
  for i in 0...c
    if i == to_idx[i]
      next
    elsif to_idx[i] < i
      i.downto(to_idx[i]+1) do |j|
        row = Array.new(c){|k| "."}
        row[j] = "/"
        grid << row
      end
    elsif i < to_idx[i]
      i.upto(to_idx[i]-1) do |j|
        row = Array.new(c){|k| "."}
        row[j] = "\\"
        grid << row
      end
    end
  end

  grid << Array.new(c){|j| "."}

# grid.each do |e|
#   puts e.join("")
# end
# puts "**** pull up"

opt_grid = grid.dup

  # opt_grid = [ Array.new(c){|j| "."} ]
  # first = Array.new(c){|j| true}

  # (grid.size-1).downto(0) do |r|
  #   use = false
  #   for i in 0...c
  #     if grid[r][i] != "." && first[i]
  #       use = true
  #       first[i] = false
  #     end
  #   end

  #   if use
  #     opt_grid = [grid[r]] + opt_grid
  #   end
  # end

# opt_grid.each do |e|
#   puts e.join("")
# end

  # ------------- pull up
  for y in 1...opt_grid.size-1
    for x in 1...c-1
      if opt_grid[y][x] == "/"
        cx = x
        cy = y
        while cy >= 1 do
          if opt_grid[cy-1][cx] == "." && opt_grid[cy-1][cx+1] != "/" && opt_grid[cy][cx-1] != "/"
            opt_grid[cy][cx] = "."
            cy -= 1
            opt_grid[cy][cx] = "/"
          else
            break
          end
        end
# opt_grid.each do |e|
#   puts e.join("")
# end
# puts "*"
      elsif opt_grid[y][x] == "\\"
        cx = x
        cy = y
        while cy >= 1 do
# pp cx, cy
          if opt_grid[cy-1][cx] == "." && opt_grid[cy-1][cx-1] != "\\" && opt_grid[cy][cx+1] != "\\"
            opt_grid[cy][cx] = "."
            cy -= 1
            opt_grid[cy][cx] = "\\"
          else
            break
          end
        end
# opt_grid.each do |e|
#   puts e.join("")
# end
# puts "*"
      end
    end
  end

# puts "-----"

# opt_grid.each do |e|
#   puts e.join("")
# end
# puts "**** remove useless"

  # ------------- remove useless
  loop do
    changed = false
    (opt_grid.size-1-1).downto(1) do |y|
      for x in 1...c-1
        if opt_grid[y][x] == "/"
          if opt_grid[y-1][x] == "/" && opt_grid[y-1][x+1] != "/"
            opt_grid[y][x] = "."
            changed = true
          end
        elsif opt_grid[y][x] == "\\"
          if opt_grid[y-1][x] == "\\" && opt_grid[y-1][x-1] != "\\"
            opt_grid[y][x] = "."
            changed = true
          end
        end
      end
    end
    break if !changed
  end

# opt_grid.each do |e|
#   puts e.join("")
# end
# puts "**** remove useless 2"

  # ------------- remove useless 2
  # loop do
  #   changed = false
  #   for y in 0...opt_grid.size-1
  #     for x in 1...c-1
  #       if opt_grid[y][x] == "/"
  #         if opt_grid[y+1][x] == "/"
  #           opt_grid[y][x] = "."
  #           changed = true
  #         end
  #       elsif opt_grid[y][x] == "\\"
  #         if opt_grid[y+1][x] == "\\"
  #           opt_grid[y][x] = "."
  #           changed = true
  #         end
  #       end
  #     end
  #   end
  #   break if !changed
  # end

  opt_grid.reject! do |e|
    e.all? do |e1|
      e1 == "."
    end
  end

  opt_grid << Array.new(c){|j| "."}

  opt_grid.each do |e|
    raise if e.first != "." || e.last != "."
    str = e.join("")
    puts str
    raise if str.match(/\\\//)
  end

  puts "Case ##{case_index}: #{opt_grid.size}"
  opt_grid.each do |e|
    puts e.join("")
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
