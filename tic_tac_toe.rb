# Pseudo-Code:

# create TicTacToe class
  # initialize a board.. so that on creation of new instance of game a board is created
# create a game board
  # board is 3x3 nested array numbered 1-9
# //draw the tic tac toe boxes - 3 x 3 boxes.
# //have player1 input a number..
#   //So X will appear inplace of number player enters.
#     //after x appears, check for a win..
        # if no win, keep playing, pcs turn, if 3 in a row, then end game.
#       //a win is 3 in a row diagonal,
# //have pc input an O
#   //the pc move will place an O in a random spot that is empty.
#     //so first check if spot is empty , if so place o, if not try another random spot on board.

# in this game.. create a board
# in this game.. see if theres a vertical win, horizontal win, diagonal win.
# in this game.. type a number to replace it with an X and check for 3 x's win.
# -----------------------------------------------------------------------------------------------------

KEY = ['X','X','X']
PC = ['O','O','O']

class TicTacToe
  def initialize(board)
    @board = board
  end

  def intro
    puts "please enter your name:"
    @player1 = gets.chomp
    puts "welcome #{@player1}"
    puts "You will be playing against the PC"
    puts
    display_board
    playerMove
  end


  private

  def playerMove
    puts "please enter the number where you would like to place an X:"
    puts
    # player enters number 1-9  --player1_move
    player1_move = gets.chomp


    # we have .match which returns the letter or number that actually matches the regexp
    # we have =~ which returns the index of the first thing that matches in the string
    # we have === which returns true or false when comparing regexp against a string

    # if playermove is a string digit 1-9..
    if /[1-9]/ === player1_move
    #   then convert it to integer..
      # player1_move.to_i
      # puts "yes.. the number is a string and matches 1-9"
      if player1_move.length == 1
        player1_move = player1_move.to_i
      else
        puts "you entered a number longer than 1 digit!..try again.."
        puts
        playerMove
      end
    # else if its a string letter or symbol..
    else
    #   then its a string so show message to enter a number ..
      puts "U didnt enter a number..Please enter a number from 1-9!"
      puts
      playerMove
    end

    # flatten the nested array game board
    @flat_board = @board.flatten

    #SIDE NOTE: if u change position 1 to X .. then u ask for the index of 1 .. it wont find it bc its changed to X!!!!  That's why its erroring out.

    if @flat_board[player1_move - 1] == 'X' || @flat_board[player1_move - 1] == 'O'
        puts "#{@player1}..that SPOT IS TAKEN.. Enter an open number please!"
        display_board
        puts
        playerMove
    else

      # program searches for index in the array of the number the player entered.
      replace_num_with_x = @flat_board.index {|x| x == player1_move}
      # program finds that number in the nested array and replaces it with an X
      @flat_board[replace_num_with_x] = 'X'

      #rebuild the nested array from flattened array..
      @new_board = []
      while !(@flat_board.empty?)
        @board = @new_board.push(@flat_board.shift(3)) #so here flat_board is empty again.. fix that!
      end

      #show the board w X's
      display_board

      # check for a win.. if not switch to PC turn..
      if checkWin == "WINNER!"
        puts "Game Over... #{@player1} WINS!!!"
      else
        #switch player
        pcMove
      end
    end
  end

  # PCs turn.
  def pcMove
    puts "pc will select random square..."
    # pc enters RANDOM number bt the numbers left in the array.
    randomNum = rand(9) + 1
    @flat_board = @board.flatten
    # p @flat_board

    # PC check board to make sure can play.. if no numbers 1-9 left on board, then game over.
    if @flat_board.any? {|x| x.class == Fixnum}      #....its pc turn so check to make sure there are numbers left to choose from in the array..   .....nice! i figured that out!....

      if @flat_board.include?(randomNum)  #...if the num pc chooses is in the array.. continue..

      # program searches for index in the array of the number the pc entered.
        pcNumIndex = @flat_board.index(randomNum)

        #program will search for the number in the array in replace with a 'O'
        @flat_board[pcNumIndex] = 'O'
        # p @flat_board
        @new_board = []
        while !(@flat_board.empty?)
          @board = @new_board << @flat_board.shift(3)
          # p @board
        end
        display_board
        if checkWin == "WINNER!"
          puts "Game Over.. PC WINS!!!"
        else
          playerMove
        end
      else #call pcMove again if PC chooses a number that has already been chosen!
        pcMove
      end
    else #if no more moves left on board output this..
      puts "GAME OVER!.. NO MOVES LEFT"
    end
  end

  # check for a win..
  def checkWin
    if vertical_win || horizontal_win || diagonal_win || top_right_diagonal_win
     "WINNER!"
    end
  end

  # build win conditions
  def vertical_win
    if @board.transpose.any? {|row| row == PC} || @board.transpose.any? {|row| row == KEY}
      return true
    end
  end

  def horizontal_win
    if @board.any? {|row| row == PC} || @board.any? {|row| row == KEY}
      return true
    end
  end

  def diagonal_win
    test = @board.map.with_index { |row,i| 'X' if row[i] == 'X'}
    other = @board.map.with_index { |row,i| 'O' if row[i] == 'O'}
    if test == KEY || other == PC
      return true
    end
  end

  def top_right_diagonal_win
    test = @board.reverse.map.with_index {|row,i| 'X' if row[i] == 'X' }
    other = @board.reverse.map.with_index { |row,i| 'O' if row[i] == 'O'}
    if test == KEY || other == PC
      return true
    end
  end

  # display the board..
  def display_board
    @board.each do |row|
      row.each do |num|
        print "#{num}\t"
      end
    puts
    end
  end
end


#define the board..
board = [[1, 2, 3],
         [4, 5, 6],
         [7, 8, 9]]

# run the game..
new_game = TicTacToe.new(board)
new_game.intro



