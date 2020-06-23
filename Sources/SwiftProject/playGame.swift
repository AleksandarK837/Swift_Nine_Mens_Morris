class PlayGame {
    private var currentPlayerTurn: Token
    private var boardGame: BoardGame

    init() {
        self.currentPlayerTurn = Token.Player1
        boardGame = BoardGame()
    }
    
    func putPlayersPieces() throws {
        while boardGame.player1.playerPlacedPieces < 9 && boardGame.player2.playerPlacedPieces < 9 {

            boardGame.printBoard()
            print("Enter coordinates for \(currentPlayerTurn): ")
            let coordinate = inputCoordinates()
    
            do {
                try boardGame.putPieceAt(coordinate: coordinate, player: currentPlayerTurn)

                if boardGame.isInMillPosition(coordinate: coordinate, player: currentPlayerTurn) {
                   let otherPlayer = currentPlayerTurn == Token.Player1 ? Token.Player2 : Token.Player1
                   try removePlayerPiece(player: otherPlayer)
                }

                if currentPlayerTurn == Token.Player1 {
                    currentPlayerTurn = Token.Player2
                } else {
                    currentPlayerTurn = Token.Player1
                }
                
            } catch gameError.non_existanceCurrentPosition(let row, let column) {
                print("Position like \(column)\(row) doesn't exist! Please enter new coordinates!")
            } catch gameError.ocupiedPosition(let row, let column) {
                print("Position \(column)\(row) is occupied! Please enter new coordinates!")
            }
        }
    }

    func movePlayerPieces() throws {
        boardGame.printBoard()

        print("Enter start coordinates for \(currentPlayerTurn): ")
        let startCoordinate = inputCoordinates()

        print("Enter end coordinates for \(currentPlayerTurn): ")
        let endCoordinate = inputCoordinates()

        do {
            try boardGame.movePiece(fromCoordinate: startCoordinate, toCoordinate: endCoordinate, player: currentPlayerTurn)

            if boardGame.isInMillPosition(coordinate: endCoordinate, player: currentPlayerTurn) {
                let otherPlayer = currentPlayerTurn == Token.Player1 ? Token.Player2 : Token.Player1
                try removePlayerPiece(player: otherPlayer)
            }

            if currentPlayerTurn == Token.Player1 {
                currentPlayerTurn = Token.Player2
            } else {
                currentPlayerTurn = Token.Player1
            }

        } catch gameError.non_existanceCurrentPosition(let row, let column) {
            print("Start position like \(column)\(row) doesn't exist! Please, enter new coordinates!")
        } catch gameError.non_existanceFinalPosition(let row, let column) {
            print("End position like \(column)\(row) doesn't exist! Please enter new coordinates!")
        } catch gameError.ocupiedPosition(let row, let column) {
            print("Position \(column)\(row) is occupied! Please, enter new coordinates!")
        } catch gameError.cantFly(let player) {
            print("Player \(player) can't fly! Please, enter new coordinates!")
        } catch gameError.moveFromEmptyPosition(let row, let column) {
            print("Start position \(row)\(column) is empty! Please, move again!")
        } catch gameError.moveOponentsPiece {
            print("Cen't move opponent's piece! Pleace, move again!")
        }
    }

    private func removePlayerPiece(player: Token) throws {
        let currentPlayerRef = boardGame.player1.player == player ? boardGame.player1 : boardGame.player2
        
        var pieces: Int
        repeat {
            pieces = currentPlayerRef.numberPiecesOnBoard
            print("Enter coordinates to remove oponent's piece: ")
            let coordinate = inputCoordinates()
            do {
                try boardGame.removePiece(player: player, coordinate: coordinate)
            } catch gameError.non_existanceCurrentPosition(let row, let column) {
                print("Position like \(row)\(column) doesn't exist! Please, enter coordinates again!")
            } catch gameError.removeEmptyPosition(let row, let column) {
                print("Position like \(row)\(column) is empty! Please, enter coordinates again!")
            } catch gameError.removeOwnPiece {
                print("You can't remove your own piece! Please, enter coordinates again!")
            } catch gameError.takePieceFromMillPosition(let row, let column) {
                print("Piece \(column)\(row) is in mill! Can't take from mill position, unless every piece is in mill position!")
            }
        } while pieces == currentPlayerRef.numberPiecesOnBoard
    }

    public func gameStatus() -> gameStatus {
        if boardGame.player1.lostGame() {
            return .Player2_Winner
        } else if boardGame.player2.lostGame() {
            return .Player1_Winner
        } else if boardGame.player1.numberPiecesOnBoard == 3 && boardGame.player2.numberPiecesOnBoard == 3 {
            return .Tie_Result
        }

        return .Still_Playing
    }

    private func inputCoordinates() -> Coordinates {
        print("Enter row: ")
        let row = readLine()
        print("Enter column: ")
        let column = readLine()
        return Coordinates(row: Int(row!) ?? -1, column: Character(column!))
    }
}