class GameBoard

    attr_reader :board

    def initialize
        @board = Array.new(3){Array.new(3)}
        board_layout(@board)
 
    end

    public 

    def board_layout(board)
        puts " #{board[0][0]|| 1}  |  #{board[0][1] || 2}  |  #{board[0][2] || 3} "  
        puts "----+-----+----" 
        puts " #{board[1][0] || 4}  |  #{board[1][1] ||5}  |  #{board[1][2] ||6} " 
        puts "----+-----+----"  
        puts " #{board[2][0] ||7}  |  #{board[2][1] ||8}  |  #{board[2][2] ||9} "
    end

    def reset_board 
        GameBoard.new()
    end

    def move(player_action, mark)
        if !position_taken(player_action)
            @board[player_action[0]][player_action[1]] = mark
            print board_layout(@board)
            print "\n"
        else
            return "fail"
        end
    end

    def our_hash
        new_hash = {
            1 => [0,0],
            2 => [0,1],
            3 => [0,2],
            4 => [1,0],
            5 => [1,1],
            6 => [1,2],
            7 => [2,0],
            8 => [2,1],
            9 => [2,2]
        }
        return new_hash
    end


    private 

    def position_taken(player)
        coordinates = player
        if @board[coordinates[0]][coordinates[1]] != nil
            return true
        end
    end


end

