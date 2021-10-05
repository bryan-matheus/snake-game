require 'spec_helper'
describe Snake do
    let(:snake){ Snake.new(4,4) }

    describe "#new" do
        let(:snake){ Snake.new(4,4) }

        it "snake is an array of body parts" do
            expect(snake.parts).to be_kind_of(Array)
            expect(snake.parts.size).to be_eql(4)
        end

        it "initializes snake head position" do
            expect(snake.parts.first).not_to be_nil
            expect(snake.parts.first).to be_kind_of(Array)
            expect(snake.parts.first.size).to be_eql(2)
            expect(snake.parts.first.first).to be_kind_of(Integer)
            expect(snake.parts.first.last).to be_kind_of(Integer)
        end

        it "initializes snake length" do
            expect(snake.size).to be_eql(4)
        end

        it "initializes snake direction" do
            expect(snake.direction).to be_eql(:left)
        end
    end

    it "#step should add one part and remove the last one from the snake" do
        old_snake = snake
        new_head = [snake.parts.first.first,snake.parts.first.last]
        old_snake.parts.unshift(new_head).pop
        snake.step
        expect(snake.parts).to be_eql(old_snake.parts)
    end

    it "#turn should change snake's direction" do
        snake.turn('w')
        expect(snake.direction).to eql(:up)
        snake.turn('a')
        expect(snake.direction).to eql(:left)
        snake.turn('s')
        expect(snake.direction).to eql(:down)
        snake.turn('d')
        expect(snake.direction).to eql(:right)
    end

    it "#update_head updates snake's head position if snake mets wall" do
        snake_head = snake.parts.first
        snake_head[0] = 2
        snake.update_head(0, 2)
        expect(snake.parts.first).to be_eql(snake_head)
    end

    it "#increase increases snake after food being eaten" do
        expect{snake.increase}.to change{snake.size}.from(4).to(5)
        expect{snake.increase}.to change{snake.parts.length}.from(5).to(6)
    end
end
