class Food 
    attr_reader :x, :y

    def initialize(board_max_x, board_max_y)
        @x = Random.rand(board_max_x - 1)
        @y = Random.rand(board_max_y - 1)
    end

    def coordinates
        [x, y]
    end
end