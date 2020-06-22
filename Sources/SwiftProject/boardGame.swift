class BoardGame {
    private var board: Board

    private var player1 : Player
    private var player2 : Player

    init() {
        board = Board()
        player1 = Player(player: Token.Player1)
        player2 = Player(player: Token.Player2)
    }

    func putPieceAt(coordinate: Coordinates, player: Token) throws {
        guard let pos = board[coordinate] else {
            throw gameError.non_existanceCurrentPosition(row: coordinate.row, column: coordinate.column)
        }

        guard pos.hasPieceOn() == false else {
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

    private func isInMillPosition(coordinate: Coordinates, player: Player) -> Bool {
        for combination in board.millsCombination[coordinate]! {
            if board[combination[0]]!.player == player.player && board[combination[1]]!.player == player.player {
                return true
            }
        }
        return false
    }

    func removePiece(player: Token) throws {
        print("Enter row coordinate: ")
        let row = readLine()
        print("Enter column coordinate: ")
        let column = readLine()

        let coordinate = Coordinates(row: Int(row!) ?? -1, column: Character(column!))

        guard let pos = board[coordinate] else {
            throw gameError.non_existanceCurrentPosition(row: coordinate.row, column: coordinate.column)
        }

        guard pos.hasPieceOn() == true else {
            throw gameError.removeEmptyPosition(row: coordinate.row, column: coordinate.column)
        }

        guard pos.player != player else {
            throw gameError.removeOwnPiece
        }

        pos.removePlayerPiece()
    }

    func movePiece(_ fromCoordinate: Coordinates, _ toCoordinate: Coordinates, _ player: Token) throws {

        guard let currentPos = board[fromCoordinate] else {
            throw gameError.non_existanceCurrentPosition(row: fromCoordinate.row, column: fromCoordinate.column)
        }

        guard let finalPos = board[toCoordinate] else {
            throw gameError.non_existanceFinalPosition(row: toCoordinate.row, column: toCoordinate.column)
        }

        let playerRef = (player == player1.player ? player1 : player2)
        
        if !playerRef.canFly {
            guard currentPos.isAdjacent(coordinate: toCoordinate) else {
                throw gameError.cantFly(player: playerRef.player)
            }
            guard finalPos.hasPieceOn() == false else {
                throw gameError.ocupiedPosition(row: toCoordinate.row, column: toCoordinate.column) 
            }
        }
        else {
            guard finalPos.hasPieceOn() == false else {
                throw gameError.ocupiedPosition(row: toCoordinate.row, column: toCoordinate.column) 
            }
        }

        currentPos.removePlayerPiece()
        finalPos.setPlayerPiece(player: playerRef.player)
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