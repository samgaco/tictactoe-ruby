class Player

    attr_accessor :mark, :player_action

    def initialize
        @player_action = [nil,nil]
        @mark = "N"        
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


end