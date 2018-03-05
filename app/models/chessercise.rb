class Chessercise
  attr_reader :column, :row, :directions_flag, :moves, :board, :xy

  def initialize
    @column = ['a','b','c','d','e','f','g','h']
    @row = [8,7,6,5,4,3,2,1]
    @moves = ['move_down','move_up','move_right','move_left']
    @directions_flag = {'move_down':1,'move_up':1,'move_right':2,'move_left':2}
    @xy = {'a':1,'b':2,'c':3,'d':4,'e':5,'f':6,'g':7,'h':8}
    @board = get_board()
  end

  # Below fucntion help in moving piece position by 1 in respective directions
  def move_down(now)
      if (now[1]) != 1
          return @board[(8 - (now[1])) + 1][@column.index(now[0])]
        end
      end

  def move_down_right(now)
      if (now[1]) != 1 and now[0] != "h"
          return @board[(8 - (now[1])) + 1][@column.index(now[0])+1]
          end
      end

  def move_down_left(now)
      if (now[1]) != 1 and now[0] != "a"
          return @board[(8 - (now[1])) + 1][@column.index(now[0])-1]
          end
      end

  def move_up(now)
      if (now[1]) < 8
          return @board[(8 - (now[1])) - 1][@column.index(now[0])]
          end
      end

  def move_up_right(now)
      if (now[1]) < 8 and now[0] != "h"
          return @board[(8 - (now[1])) - 1][@column.index(now[0])+1]
          end
      end

  def move_up_left(now)
      if (now[1]) < 8 and now[0] != "a"
          return @board[(8 - (now[1])) - 1][@column.index(now[0])-1]
          end
      end

  def move_right(now)
      if now[0] != "h"
          return @board[(8 - (now[1]))][@column.index(now[0]) + 1]
          end
      end

  def move_left(now)
      if now[0] != "a"
          return @board[(8 - (now[1]))][@column.index(now[0]) - 1]
          end
      end

  # building chess board
  def get_board
    line_board = []
    for current_row in @row do
      line = []
      for current_column in @column do
          value = current_column + current_row.to_s
          line.push(value)
      end
      line_board.push(line)
  end
  line_board
  end

  def getposition(position)
      return [position[0], position[-1].to_i]
  end

  def Knight(position)
      # print position
      possible_moves = []
      chessercise = Chessercise.new
      for i in @moves do
          for j in @moves do
              now = getposition(position)
              if i != j
                  if @directions_flag[i.to_sym] != @directions_flag[j.to_sym]
                      if chessercise.send(i.to_sym, now) != nil
                          mv_now = chessercise.send(i.to_sym, now)
                          now = getposition(mv_now)
                          if chessercise.send(j.to_sym, now) != nil
                              mv_now = chessercise.send(j.to_sym, now)
                              now = getposition(mv_now)
                              if chessercise.send(j.to_sym, now) != nil
                                  mv_now = chessercise.send(j.to_sym, now)
                                  possible_moves.push(mv_now)
                              end
                          end
                      end
                  end
              end
          end
      end
      return possible_moves
  end

  def ROOK(position)
    now = getposition(position)
    possible_moves = @column.map { |x| x.to_s + now[1].to_s}
    possible_moves.delete_at(possible_moves.index(position))
    possible_moves += @row.map { |x| now[0].to_s + x.to_s}
    possible_moves.delete_at(possible_moves.index(position))
    return possible_moves
  end

  def QUEEN(position, set)
    now = getposition(position)
    possible_moves = []
    if set == "a" or set == 'all'
        possible_moves = @column.map { |x| x.to_s + now[1].to_s}
        possible_moves.delete_at(possible_moves.index(position))
    end
    if set == "a"
      return possible_moves
    end

    if set == "b" or set == 'all'
      possible_moves += @row.map { |x| now[0].to_s + x.to_s}
      possible_moves.delete_at(possible_moves.index(position))
    end
    if set == "b"
        return possible_moves
    end

    k = @column.index(now[0]).to_i
    column_above = []
    column_below = []

    while k < @column.length
      column_above << @column[k + 1]
      k+= 1
    end

    k = @column.index(now[0]).to_i
    while k > 0
      column_below << @column[k - 1]
      k-= 1
    end
    if set == "c" or set == 'all'
        count = 1
        for i in column_below do
            if now[1] - count > 0
                possible_moves.push(i + (now[1] - count).to_s)
              end
            if now[1] + count < 9
                possible_moves.push(i + (now[1] + count).to_s)
              end
            count += 1
          end
        end
    if set == "c"
        return possible_moves
    end

    if set == "d" or set == 'all'
        count = 1
        for i in column_above do
            if now[1] - count > 0
                possible_moves.push(i + (now[1] - count).to_s)
            end
            if now[1] + count < 9
                possible_moves.push(i + (now[1] + count).to_s)
            end
            count += 1
        end
    end
    if set == "d"
        return possible_moves
      end
    if set == "all"
        return possible_moves
      end
  end


  # Returns path of a piece when postion and direction is provided
  def inpath(position, direction)
      now = getposition(position)
      path = []
      chessercise = Chessercise.new
      for i in (1..9) do
          if chessercise.send(direction.to_sym, now) == nil
            break
          end
          now = chessercise.send(direction.to_sym, now)
          path.push(now)
          now = getposition(now)
      end
      return path
  end

  # Finds longest length and check if current tile comes under target
  def path_len_tile(path, target)
      # print target
      if path
          result = nil
          for i in path
              # print i
              if target.include? i
                  # print "In target"
                  result = i, path.index(i)
                  break
              end
          end
          # print result
          if result == nil
              result = path[-1], path.index(path[-1])
          end
      else
          result = 0,0
      end
      # print result
      return result
  end

  # Function to find longest path for Queen
  def QUEEN_long_path(position, target)
      now = getposition(position)
      moves = ['move_down', 'move_up', 'move_right', 'move_left', 'move_down_right', 'move_down_left', 'move_up_right',
               'move_up_left']
      steps = 0
      long_position = ''
      for i in moves do
          # print i
          path = inpath(position, i)
          # print path
          long_tile = path_len_tile(path, target)
          # print long_tile
          if long_tile.any? && long_tile[1] > steps
              steps = long_tile[1]
              long_position = long_tile[0]
          end
      end

      return [long_position, steps+1]
  end

  # Function to find longest path for Rook
  def ROOK_long_path(position, target)
      now = getposition(position)
      moves = ['move_down', 'move_up', 'move_right', 'move_left']

      steps = 0
      long_position = ''
      for i in moves do
          path = inpath(position, i)
          # print path
          long_tile = path_len_tile(path, target)
          # print long_tile
          if long_tile.any? && long_tile[1] > steps
              steps = long_tile[1]
              long_position = long_tile[0]
          end
      end
      return [long_position, steps + 1]
      # print ROOK_long_path('h5')
  end

  # Function to find longest path for Knigh
  def Knight_long_path(position, target)
      possible_moves = []
      moves = ['move_down', 'move_up', 'move_right', 'move_left']
      chessercise = Chessercise.new
      for i in moves do
                for j in moves do
                    now = getposition(position)
                    if i != j
                        if @directions_flag[i.to_sym] != @directions_flag[j.to_sym]
                            if chessercise.send(i.to_sym, now) != nil
                                mv_now = chessercise.send(i.to_sym, now)
                                now = getposition(mv_now)
                                if chessercise.send(j.to_sym, now) != nil
                                    mv_now = chessercise.send(j.to_sym, now)
                                    now = getposition(mv_now)
                                    if chessercise.send(j.to_sym, now) != nil
                                        mv_now = chessercise.send(j.to_sym, now)
                                        possible_moves.push(mv_now)
                                    end
                                end
                            end
                        end
                    end
                end
            end
      return possible_moves
      # print Knight_long_path('d2')
  end

end


piece = ARGV[1]
position = ARGV[3]
target = ARGV[5]

chessercise = Chessercise.new
print "pieceeeee", piece

if piece == 'KNIGHT'
    print "Possible positions: ",chessercise.Knight(position)
elsif piece == 'QUEEN'
    print "Possible positions: ",chessercise.QUEEN(position,'all')
elsif piece == 'ROOK'
    print "Possible positions: ",chessercise.ROOK(position)
else
    print "piece not found"
end


if piece == 'KNIGHT' && target != nil
    print "Longest path: ",chessercise.Knight_long_path(position, target)
elsif piece == 'QUEEN' && target != nil
    print "Longest path: ",chessercise.QUEEN_long_path(position, target)
elsif piece == 'ROOK' && target != nil
    print "Longest path: ",chessercise.ROOK_long_path(position, target)
else
    print "piece not found"
end
