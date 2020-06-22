class Position {
    
    public private(set) var coordinate: Coordinates
    public private(set) var player: Token
    public private(set) var adjacents: [Coordinates]
    internal var isOcupied: Bool

    init(coordinate: Coordinates) {
        self.coordinate = coordinate
        self.isOcupied = false
        self.player = Token.NoPlayer
        adjacents = []
        setAdjacents() 
    }

    internal func hasPieceOn() -> Bool {
        if player == Token.NoPlayer {
            return false
        }
        return true
    }

    public func setPlayerPiece(player: Token) {
        self.player = player
        isOcupied = true
    }

    public func removePlayerPiece() {
        self.player = Token.NoPlayer
        isOcupied = false
    }

    public func isAdjacent(coordinate: Coordinates) -> Bool {
        for adj in adjacents {
            if adj == coordinate {
                return true
            }
        }
        return false
    }
    private func setAdjacents() {
        if coordinate == A1 {
            adjacents = [A4, D1]
        } else if coordinate == A4 {
            adjacents = [A1, A7, B4]
        } else if coordinate == A7 {
            adjacents = [A4, D7]
        } else if coordinate == D1 {
            adjacents = [A1, D2, G1]
        } else if coordinate == G1 {
            adjacents = [D1, G4]
        } else if coordinate == D7 {
            adjacents = [A7, D7, D6]
        } else if coordinate == G7 {
            adjacents = [G4, D7]
        } else if coordinate == G4 {
            adjacents = [G1, G7, F4]
        } else if coordinate == B2 {
            adjacents = [B4, D2]
        } else if coordinate == B4 {
            adjacents = [A4, C4, B2, B6]
        } else if coordinate == B6 {
            adjacents = [B4, D6]
        } else if coordinate == D2 {
            adjacents = [D1, D3, B2, F2]
        } else if coordinate == F2 {
            adjacents = [D2, F4]
        } else if coordinate == D6 {
            adjacents = [D5, D7, B6, F6]
        } else if coordinate == F6 {
            adjacents = [D6, F4]
        } else if coordinate == F4 {
            adjacents = [E4, G4, F2, F6]
        } else if coordinate == C3 {
            adjacents = [D3, C4]
        } else if coordinate == E3 {
            adjacents = [D3, E4]
        } else if coordinate == D3 {
            adjacents = [C3, E3, D2]
        } else if coordinate == C4 {
            adjacents = [C3, C5, B4]
        } else if coordinate == C5 {
            adjacents = [C4, D5]
        } else if coordinate == D5 {
            adjacents = [C5, E5, D6]
        } else if coordinate == E5 {
            adjacents = [D5, E4]
        } else if coordinate == E4 {
            adjacents = [E3, E5, F4]
        }
    }
}