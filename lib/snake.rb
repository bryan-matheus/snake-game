class Snake
    attr_reader :size, :direction, :position, :parts

    def initialize(max_x, max_y)
        @size = 4
        @direction = :left
        @parts = []
        set_start_position(max_x, max_y)
        create_snake
    end
  
    def create_snake
        size.times do |iteration|
            @parts << [position[0], position[1] + iteration]
        end
    end
  
    def head
        parts.first
    end
  
    def body
        parts[1..parts.length-1]
    end
  
    def set_start_position(max_x, max_y)
        @position = [Random.rand(0..max_x - 1), Random.rand(0..max_y - 1)]
    end
  
    def increase
        @size += 1
        @parts << parts.last
    end
  
    def update_head(idx, value)
        @parts.first[idx] = value
    end
  
    def turn(key_code)
        @direction = case key_code.chr
        when 'w' || 'W'
            :up
        when 's' || 'S'
            :down
        when 'a' || 'A'
            :left
        when 'd' || 'D'
            :right
        else
            direction
        end
    end
  
    def step
        new_head = [head.first,head.last]
        case direction
        when :left
            new_head[1] -= 1
        when :right
            new_head[1] += 1
        when :up
            new_head[0] -= 1
        when :down
            new_head[0] += 1
        end
        parts.unshift(new_head)
        parts.pop
    end
end