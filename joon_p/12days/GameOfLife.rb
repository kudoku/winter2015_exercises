# Conway's Game of Life Ver. 1

# set and display a matrix that iterates through a certain number of times
# 1. display a menu that sets the board x and y lengths and # of generations
# 2. create a board that uses these x and y and randomly fill with "on" "off"
# 3. display board
# 4. check current cell state 
# 5. check matrix border and determine if current cell lives or dies by checking neighbors
# 5. display next cell state
# 6. keep iterating through the generations until done
# check cell neighbors to determine current cell state
#   Rules:
# Any live cell with fewer than two live neighbours dies, as if caused by under-population.
# Any live cell with two or three live neighbours lives on to the next generation.
# Any live cell with more than three live neighbours dies, as if by overcrowding.
# Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.


class Board

  NEIGHBORS = [
  [-1,-1], [-1, 0], [-1, 1],
  [ 0,-1], [ 0, 0], [ 0, 1],
  [ 1,-1], [ 1, 0], [ 1, 1]]

  def initialize
    p "Enter board dimensions: rows "
    @max_rows = gets.chomp.to_i

    p "Enter board dimensions: columns"
    @max_columns = gets.chomp.to_i

    p "Enter # of loops"
    @generations = gets.chomp.to_i

    @counter = 0

    board_generate
    
  end

  def menu
    p 'Want to play again? (y/n)'
    input = gets.chomp.downcase
    if input == 'y'
      new_game = Board.new
    elsif input == 'n'
      exit
    else
      p '*'*15
      p 'Enter a valid input (y/n)'
      p '*'*15
      menu
    end
  end

  def board_generate
    #generate board 
    # srand(2)
    arr = [" ", 0]
    @board_current = Array.new(@max_rows) do |row|
      row = Array.new(@max_columns) {arr[rand(2)]}
    end
    @board_next_state = @board_current

    current_cell_state
  end

  def current_cell_state
    #check each cell 
    @counter += 1
    @board_current.each_with_index do |array, y_index|
      array.each_with_index do |value, x_index|
        @current_column = x_index
        @current_row = y_index
        @current_cell = value
        
        neighbor_check
        apply_rules
      end
    end
    display
  end

  def display
    loop do 
      system("clear")
      p "Generation #: #{@counter}"
      @board_next_state.each do |row|
        puts row.map { |cell| cell }.join(" ")
      end
      sleep(1)
      @board_current = @board_next_state
      if @counter < @generations
        current_cell_state 
      else
        break
      end
      break 
    end
    p 'Thanks for playing, please come again.'
    menu
  end

  def is_alive?(row, column)
    @board_current[row][column] == 0
  end

  def out_of_bounds?(position, boundary)
    position < 0 || position > boundary 
  end
      
  def neighbor_check
    board_check = @board_current
    @neighbor_count = 0

    NEIGHBORS.each do |test_position|
      test_row = @current_row + test_position.first
      test_column = @current_column + test_position.last

      if out_of_bounds?(test_row, @max_rows-1)
        next
      end
      if out_of_bounds?(test_column, @max_columns-1)
        next
      end

      if test_position.first == 0 && test_position.last == 0 
        next
      end

      if is_alive?(test_row, test_column)
        @neighbor_count += 1
      end

    end
    @neighbor_count
  end 

  def apply_rules
    if is_alive?(@current_row, @current_column)
      #apply living rules
      if @neighbor_count < 2
        @board_next_state[@current_row][@current_column] = " "
      elsif @neighbor_count > 3
        @board_next_state[@current_row][@current_column] = " "
      else
        @board_next_state[@current_row][@current_column] = 0
      end
    else
      #apply dead cell rules
      if @neighbor_count == 3
        @board_next_state[@current_row][@current_column] = 0 
      end
    end
  end

end #class end

      
new_game = Board.new
