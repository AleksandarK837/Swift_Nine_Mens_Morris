class Player {
    public private(set) var canFly: Bool
    public private(set) var player: Token
    public private(set) var numberPiecesOnBoard: Int
    
    init(player: Token) {
        canFly = false
        self.player = player
        numberPiecesOnBoard = 0
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
    }
}