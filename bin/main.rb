require_relative '../lib/game_board.rb'
require_relative '../lib/player.rb'

class GameInterface

    def initialize   
        print "\n Starting a new game \n \n"
        game_instruction
        @board_this_game = GameBoard.new()
        @player1 = Player.new()
        @player2 = Player.new()
        @current_player = @player1
        @player_name_now = "player1"
        @game_stops = false
        @count = 0
        @game_finish = 0
        @no_draw = 0
        @win_already = 0
    end  

    public

    def play_game
        ask_for_mark
        until @game_stops == true
            which_players_turn
            ask_for_move
            move_and_check
            win_game
            check_draw
            switch_player
        end
    end

    def game_instruction
        puts "***************************************"
        puts "*** Welcome To My Tic-Tac-Toe Game! ***"
        puts "***************************************"
        puts "======================================="
        puts "**************** RULES ****************"
        puts "Two players will take turns to mark the"
        puts "spaces on a 3x3 grid. The player who   "
        puts "succeeds in placing 3 of their marks in"
        puts "a horizontal, vertical, or diagonal row"
        puts "wins the game. When there are no more  "
        puts "spaces left to mark, it is consider a  "
        puts "draw. To place a mark on the grid, type"
        puts "the number on the space you would like "
        puts "to mark! As shown below. Good luck! \n "
    end

    def ask_for_mark
        puts "\n"
        puts "\n Player1, Which mark will you like to use ? select one of these:
         1 = 'X' 
         2 = 'O'"
        print "\n Player1 choose a mark:  "
        players_mark = gets.chomp().to_i
        while !players_mark.between?(1,2)
            puts "you entered a wrong value, please select either 1 or 2 \n"
            print "\n Player1 choose a mark:   "
            players_mark = gets.chomp().to_i
        end
        if players_mark == 1 
            @player1.mark = "x".upcase
            @player2.mark = "o".upcase
        else
            @player1.mark = "o".upcase
            @player2.mark = "x".upcase
        end
        if  @player1.mark == "X"
            puts "player1 your mark is 'X' \n"
            puts "player2 your mark is 'O' \n"
        else
            puts "player1 your mark is '0' \n"
            puts "player2 your mark is 'X' \n"
        end
    end

    def which_players_turn
        if @player_number == "player1"
            print "\n Player1 is your turn. \n"
        elsif @player_number == "player2"
            print "\n Player2 is your turn \n"
        end
    end

    def ask_for_move
        print "\n Choose a number: "
        move_x = gets.chomp().to_i
        while !move_x.between?(1,9)
            puts "you entered a wrong number, enter number from 1 to 9 \n"
            print "\n Choose a number: "
            move_x = gets.chomp().to_i
        end
        choosen_coordinates = @current_player.our_hash[move_x]
        @current_player.player_action = choosen_coordinates

    end

    def move_and_check
        print "\n"
        if @board_this_game.move(@current_player.player_action, @current_player.mark) == "fail"
            @count -=1
            switch_player
            puts "\n That number is already taken! \n"
            puts " \n"
            @board_this_game.board_layout(@board_this_game.board)
            puts "\n Take another one... \n"   
        else
            @board_this_game.move(@current_player.player_action, @current_player.mark)
        end
    end

    def win_game
        check_horizontal_win(@board_this_game.board) if @win_already == 0
        check_vertical_win(@board_this_game.board) if @win_already == 0
        check_diagonal_win(@board_this_game.board) if @win_already == 0
    end

    def check_horizontal_win(board)
        i = 0
        3.times do 
            if board[i][0] == "X" && board[i][1]  == "X" && board[i][2] == "X"
                winner_text(@player_number)
                game_stops
                @no_draw = 1 if @count == 8
            elsif board[i][0] == "O" && board[i][1]  == "O" && board[i][2] == "O"
                winner_text(@player_number)
                game_stops
                @no_draw = 1 if @count == 8
            end
            i += 1
        end
    end

    def check_vertical_win(board)    
        for i in 0..3
            if board[0][i] == "X" && board[1][i]  == "X" && board[2][i] == "X"
                winner_text(@player_number)
                game_stops
                @no_draw = 1 if @count == 8
            elsif  board[0][i] == "O" &&  board[1][i]  == "O" && board[2][i] == "O"
                winner_text(@player_number)
                game_stops         
                @no_draw = 1 if @count == 8
            end
        end
    end

    def check_diagonal_win(board)     
        if board[0][0] == "X" && board[1][1] == "X" && board[2][2] == "X"
            winner_text(@player_number)
            game_stops
            @no_draw = 1 if @count == 8
        elsif board[0][0] == "O" && board[1][1] == "O" && board[2][2] == "O"
            winner_text(@player_number)
            game_stops
            @no_draw = 1 if @count == 8
        elsif board[2][0] == "X" && board[1][1] == "X" && board[0][2] == "X"
            winner_text(@player_number)
            game_stops
            @no_draw = 1 if @count == 8
        elsif board[2][0] == "O" && board[1][1] == "O" && board[0][2] == "O"
            winner_text(@player_number)
            game_stops
            @no_draw = 1 if @count == 8
        end
    end

    def game_stops
        @game_finish = 1
        @game_stops = true
        @win_already = 1
        print "\n Game is finished! \n"
    end

    def check_draw
        if @count == 8 && @no_draw == 0 
            draw_text
            game_stops
        else
            @count += 1
        end
    end

    def play_again
        puts "\n do you want to play again 'yes' to play again or any key to exit"
        answer = gets.chomp().downcase
        if answer == "yes"
            # @board_this_game = GameBoard.new()
            @count = 0
            @game_finish = 0
            @no_draw = 0
            @win_already = 0
            @current_player = @player1
            @player_number = "player1"
            @game_stops = false
            @board_this_game =  @board_this_game.reset_board
            self.play_game
        else
            puts "\n"
            puts "\n *********Thank you for playing**********\n"
            puts "\n"
        end
        
    end

    def switch_player
        if @count == 9 || @game_finish ==1 
            play_again
        else
            if @current_player == @player1
                @current_player = @player2
                @player_number = "player2"
            else
                @current_player = @player1
                @player_number = "player1"
            end
        end        
    end


    private
    def winner_text(name)
      puts "\n"
      puts '*************************************************'
      puts '**************** CONGRATULATIONS ****************'
      puts '*************************************************'
      puts "**************** #{name} Wins! *****************"
      puts '*************************************************'
    end

    def draw_text
      puts "\n"
      puts '*************************************************'
      puts '****************    GAME OVER    ****************'
      puts '*************************************************'
      puts "****************  It's a Draw!  *****************"
      puts '*************************************************'
    end




end


new_game = GameInterface.new()
new_game.play_game