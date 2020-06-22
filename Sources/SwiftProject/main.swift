
var playGame = PlayGame()
try! playGame.putPlayersPieces()

while !playGame.gameOver() {
    try! playGame.movePlayerPieces()
}
