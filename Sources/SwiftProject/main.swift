
var playGame = PlayGame()
try! playGame.putPlayersPieces()

print("-----------------Start moving-----------------")
while playGame.gameStatus() == gameStatus.Still_Playing {
    try! playGame.movePlayerPieces()
}

print("Game result: \(playGame.gameStatus())")
