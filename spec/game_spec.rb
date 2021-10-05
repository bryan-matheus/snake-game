require 'spec_helper'

describe Game do
    let(:new_game) { Game.new }

    describe "#new" do
        it "initializes game" do
            expect(new_game.gameboard).to be_kind_of(Board)
            expect(new_game.snake).to be_kind_of(Snake)
            expect(new_game.food).to be_kind_of(Food)
        end
    end

    it "#check_snake_position checks all checks successfully" do
        expect{ new_game.check_snake_position }.to_not raise_error(AteItselfError)
        expect{ new_game.check_snake_position }.to_not change{ new_game.snake.body }
    end

    it "#check_if_snake_ate_itself" do
        new_game.snake.parts[0] = new_game.snake.parts.last
        expect{ new_game.check_if_snake_ate_itself }.to raise_error(AteItselfError)
        expect{ new_game.check_snake_position }.to raise_error(AteItselfError)
    end

    it "#check_if_snake_met_wall" do
        new_game.snake.parts[0][1] = new_game.gameboard.width
        expect{ new_game.check_if_snake_met_wall }.to change{ new_game.snake.parts[0][1] }.from(new_game.gameboard.width).to(0)
        new_game.snake.parts[0][1] = new_game.gameboard.width
        expect{ new_game.check_snake_position }.to change{ new_game.snake.parts[0][1] }.from(new_game.gameboard.width).to(0)
    end

    it "#check_if_snake_ate_food" do
        new_game.snake.parts[0] = new_game.food.coordinates
        expect{ new_game.check_if_snake_ate_food }.to change{ new_game.snake.size }.from(4).to(5)
        new_game.snake.parts[0] = new_game.food.coordinates
        expect{ new_game.check_snake_position }.to change{ new_game.snake.size }.from(5).to(6)
    end

    it "#compares pressed key" do
        expect(new_game.compare_key(65, 'a')).to be_truthy
        expect(new_game.compare_key(65, 'A')).to be_truthy
        expect(new_game.compare_key(65, 'Q')).to be_falsey
    end

    it "#execute_action quit on Q" do
        expect(new_game.execute_action('q'.ord)).to eql(false)
    end

    it "#execute_action turn on a" do
        expect{ new_game.execute_action('d'.ord) }.to change{ new_game.snake.direction }.from(:left).to(:right)
        expect(new_game.execute_action('d'.ord)).not_to be_nil
    end
end