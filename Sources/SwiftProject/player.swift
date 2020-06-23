class Player {
    private(set) var canFly: Bool
    private(set) var player: Token
    private(set) var numberPiecesOnBoard: Int
    private(set) var playerPlacedPieces: Int
    
    init(player: Token) {
        canFly = false
        self.player = player
        numberPiecesOnBoard = 0
        playerPlacedPieces = 0
    }
    
    func lostGame() -> Bool {
        if numberPiecesOnBoard < 3 {
            return true
        }
        return false
    }

    func removePieceOnBoard() {
        numberPiecesOnBoard -= 1
        if numberPiecesOnBoard == 3 {
            canFly = true
        }
    }

    func addPieceOnBoard() {
        numberPiecesOnBoard += 1
        playerPlacedPieces += 1
        if numberPiecesOnBoard > 3 {
            canFly = false
        }
    }
}