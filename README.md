Run the below example commands from terminal in order to execute:

Clone the project and cd inmar_test

cd app/models/chessercise.rb

A list of all the potential board positions the given piece could advance to, with one move, from the given position, with the assumption there are no other pieces on the board.

ruby chessercise.rb -piece KNIGHT -position d2
ruby chessercise.rb -piece QUEEN -position b3
ruby chessercise.rb -piece ROOK -position c2

Determine the physically most distant tile from Current position. Calculate and output the minimum set of moves which the given pie ce Type could take to the most distant tile given that:

ruby chessercise.rb -piece KNIGHT -position a3 -target ['a8', 'c3', 'b7']
ruby chessercise.rb -piece QUEEN -position a3 -target ['a8', 'c3', 'b7']
ruby chessercise.rb -piece ROOK -position a3 -target ['a8', 'c3', 'b7']

ThoughtExcersise.md will address the ThoughtExcersise task
