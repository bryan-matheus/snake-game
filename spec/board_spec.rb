require 'spec_helper'

describe Board do
    describe "#new" do
        it "initializes gameboard with board" do
            expect(Board.new(40,40).board).not_to be_nil
        end
    end

    describe "#create_board" do
        let(:gameboard) {Board.new(40,40)}

        it "returns an array" do
            expect(gameboard.board).to be_instance_of(Array)
        end

        it "returns an array with given size" do
            expect(gameboard.board.size).to be_eql(40)
            expect(gameboard.board[0].size).to be_eql(40)
        end

        it "returns board full of . symbols" do
            expect(gameboard.board.first.first).to eql('.')
        end
    end
end