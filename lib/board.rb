class Board
    attr_reader :length, :width, :board
  
    def initialize(width, length)
        @length = length
        @width = width
        create_board
    end
  
    def center
        [board.length / 2, board.first.length / 2]
    end
  
    def print_text(text)
        char_center = text.length/2
        i = 0
        text.chars.each do |char|
            board[center.first][center.last - char_center + i] = char
            i += 1
        end
    end
  
    def create_board
        @board = Array.new(length){ Array.new(width, '.') }
    end
end