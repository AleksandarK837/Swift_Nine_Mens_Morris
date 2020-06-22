
let bg = BoardGame()
try! bg.putPieceAt(coordinate: Coordinates(row: 1, column: "A"), player: Token.Player1)
try! bg.putPieceAt(coordinate: Coordinates(row: 4, column: "A"), player: Token.Player1)
try! bg.movePiece(Coordinates(row: 4, column: "A"), Coordinates(row: 4, column: "B"), Token.Player1)
bg.printBoard()

