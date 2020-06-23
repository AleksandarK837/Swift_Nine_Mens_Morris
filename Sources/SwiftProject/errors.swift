enum gameError : Swift.Error {
    case ocupiedPosition(row: Int, column: Character)
    case non_existanceCurrentPosition(row: Int, column: Character)
    case non_existanceFinalPosition(row: Int, column: Character)
    case removeEmptyPosition(row: Int, column: Character)
    case moveFromEmptyPosition(row: Int, column: Character)
    case cantFly(player: Token)
    case takePieceFromMillPosition(row: Int, column: Character)
    case removeOwnPiece
    case moveOponentsPiece
}