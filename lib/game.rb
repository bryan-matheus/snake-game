require 'io/console'

class Game
    attr_reader :gameboard, :snake, :food

    def initialize(max_x = 11, max_y = 11)
        @gameboard = Board.new(max_x, max_y)
        @snake = Snake.new(gameboard.width, gameboard.length)
        @food = Food.new(gameboard.width, gameboard.length)
    end

    def print_board
        system('clear')
        puts "Your size is: #{snake.size} |  [Q]uit"

        gameboard.board.each do
            |line| puts line.each{ |item| item }.join(" ")
        end
    end

    def draw_food_and_snake
        gameboard.create_board

        @gameboard.board[food.x][food.y] = 'o'

        snake.parts.each do |part|
            @gameboard.board[part.first][part.last] = 'x'
        end

        print_board
    end

    def show_message(text)
        gameboard.create_board
        gameboard.print_text(text)
        print_board
    end

    def show_start_screen
        start = false

        while start == false
            show_message("[S]tart")

            key = GetKey.getkey

            sleep(0.5)

            if key && compare_key(key, 's')
                start = true
            end
        end
    end

    def check_snake_position
        check_if_snake_met_wall
        check_if_snake_ate_food
        check_if_snake_ate_itself
    end

    def check_if_snake_ate_itself
        if snake.body.include? snake.head
            raise AteItselfError
        end
    end

    def check_if_snake_met_wall
        snake.update_head(1,0) if snake.head[1] > gameboard.width - 1
        snake.update_head(1, gameboard.width - 1) if snake.head[1] > gameboard.length - 1
        snake.update_head(0, gameboard.length - 1) if snake.head[0] < 0
    end

    def check_if_snake_ate_food
        if snake.head[0] == food.x && snake.head[1] == food.y
            snake.increase
            @food = Food.new(gameboard.width, gameboard.length)
        end
    end

    def start
        show_start_screen
        begin
            tick
        rescue AteItselfError
            show_message("Game over")
        end
    end


    def tick
        in_game = true

        while in_game
            draw_food_and_snake

            sleep(0.1)

            if key = GetKey.getkey
                in_game = execute_action(key)
            end

            snake.step
            check_snake_position
        end
        show_message("Game quit")
    end

    def execute_action key
        return false if compare_key(key, 'q')
        snake.turn(key)
    end

    def compare_key(key, char)
        key.chr == char.downcase || key.chr == char.upcase
    end
end