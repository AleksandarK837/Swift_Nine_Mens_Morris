class BoardGame {
    let board: Board

    let player1 : Player
    let player2 : Player

    init() {
        board = Board()
        player1 = Player(player: Token.Player1)
        player2 = Player(player: Token.Player2)
    }

    func putPieceAt(coordinate: Coordinates, player: Token) throws {
        guard let pos = board[coordinate] else {
            throw gameError.non_existanceCurrentPosition(row: coordinate.row, column: coordinate.column)
        }

        guard !pos.hasPieceOn() else {
            throw gameError.ocupiedPosition(row: coordinate.row, column: coordinate.column)
        }

        pos.setPlayerPiece(player: player)

        if pos.player == player1.player {
            player1.addPieceOnBoard()
        }

        if pos.player == player2.player {
            player2.addPieceOnBoard()
        }
    }

    func isInMillPosition(coordinate: Coordinates, player: Token) -> Bool {
        for combination in board.millsCombination[coordinate]! {
            if board[combination[0]]!.player == player && board[combination[1]]!.player == player {
                return true
            }
        }
        return false
    }

    private func isInMillForEveryPosition(player: Token) -> Bool {
        for coordinate in coordArray {
            if board[coordinate]!.player == player {
                if !isInMillPosition(coordinate: coordinate, player: player) {
                    return false
                }
            }
        }
        return true
    }

    func movePiece(fromCoordinate: Coordinates, toCoordinate: Coordinates, player: Token) throws {

        guard let currentPos = board[fromCoordinate] else {
            throw gameError.non_existanceCurrentPosition(row: fromCoordinate.row, column: fromCoordinate.column)
        }

        guard let finalPos = board[toCoordinate] else {
            throw gameError.non_existanceFinalPosition(row: toCoordinate.row, column: toCoordinate.column)
        }

        guard currentPos.hasPieceOn() else {
            throw gameError.moveFromEmptyPosition(row: fromCoordinate.row, column: fromCoordinate.column)
        }

        guard currentPos.player == player else {
            throw gameError.moveOponentsPiece
        }
        
        let playerRef = (player == player1.player ? player1 : player2)
        
        if !playerRef.canFly {
            guard currentPos.isAdjacent(coordinate: toCoordinate) else {
                throw gameError.cantFly(player: playerRef.player)
            }
            guard !finalPos.hasPieceOn() else {
                throw gameError.ocupiedPosition(row: toCoordinate.row, column: toCoordinate.column) 
            }
        }
        else {
            guard !finalPos.hasPieceOn() else {
                throw gameError.ocupiedPosition(row: toCoordinate.row, column: toCoordinate.column) 
            }
        }

        currentPos.removePlayerPiece()
        finalPos.setPlayerPiece(player: playerRef.player)
    }

    func removePiece(player: Token, coordinate: Coordinates) throws {
        printBoard()
        
        guard let pos = board[coordinate] else {
            throw gameError.non_existanceCurrentPosition(row: coordinate.row, column: coordinate.column)
        }

        guard pos.hasPieceOn() else {
            throw gameError.removeEmptyPosition(row: coordinate.row, column: coordinate.column)
        }

        guard pos.player == player else {
            throw gameError.removeOwnPiece
        }

        if isInMillPosition(coordinate: coordinate, player: player) {
            guard isInMillForEveryPosition(player: player) else {
                throw gameError.takePieceFromMillPosition(row: coordinate.row, column: coordinate.column)
            }
        }

        pos.removePlayerPiece()
        let currentPlayerRef = player == player1.player ? player1 : player2
        currentPlayerRef.removePieceOnBoard()
    }


    func printBoard() {
        print("\(symbol(board[A1]!.player))-----------\(symbol(board[D1]!.player))-----------\(symbol(board[G1]!.player))")
        print("|           |           |")
        print("|   \(symbol(board[B2]!.player))-------\(symbol(board[D2]!.player))-------\(symbol(board[F2]!.player))   |")
        print("|   |       |       |   |")
        print("|   |   \(symbol(board[C3]!.player))---\(symbol(board[D3]!.player))---\(symbol(board[E3]!.player))   |   |")
        print("|   |   |       |   |   |")
        print("\(symbol(board[A4]!.player))---\(symbol(board[B4]!.player))---\(symbol(board[C4]!.player))       \(symbol(board[E4]!.player))---\(symbol(board[F4]!.player))---\(symbol(board[G4]!.player))")
        print("|   |   |       |   |   |")
        print("|   |   \(symbol(board[C5]!.player))---\(symbol(board[D5]!.player))---\(symbol(board[E5]!.player))   |   |")
        print("|   |       |       |   |")
        print("|   \(symbol(board[B6]!.player))-------\(symbol(board[D6]!.player))-------\(symbol(board[F6]!.player))   |")
        print("|           |           |")
        print("\(symbol(board[A7]!.player))-----------\(symbol(board[D7]!.player))-----------\(symbol(board[G7]!.player))")
    }

    private func symbol(_ player: Token) -> Character {
        if player == Token.Player1 {
            return "1"
        } else if player == Token.Player2 {
            return "2"
        } 
        return "X"
    }

}