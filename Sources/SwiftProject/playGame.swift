class PlayGame {
    private var currentPlayerTurn: Token
    private var boardGame: BoardGame

    init() {
        self.currentPlayerTurn = Token.Player1
        boardGame = BoardGame()
    }
    
    func putPlayersPieces() throws {
        while boardGame.player1.numberPiecesOnBoard < 9 && boardGame.player2.numberPiecesOnBoard < 9 {

            boardGame.printBoard()
            print("Enter coordinates for \(currentPlayerTurn): ")
            print("Enter row: ")
            let row = readLine()
            print("Enter column: ")
            let column = readLine()
            let coordinate = Coordinates(row: Int(row!) ?? -1, column: Character(column!))
    
            do {
                try boardGame.putPieceAt(coordinate: coordinate, player: currentPlayerTurn)

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
        print("Enter row: ")
        let startRow = readLine()
        print("Enter column: ")
        let startColumn = readLine()
        let startCoordinate = Coordinates(row: Int(startRow!) ?? -1, column: Character(startColumn!))

        print("Enter end coordinates for \(currentPlayerTurn): ")
        print("Enter row: ")
        let endRow = readLine()
        print("Enter column: ")
        let endColumn = readLine()
        let endCoordinate = Coordinates(row: Int(endRow!) ?? -1, column: Character(endColumn!))

        do {
            try boardGame.movePiece(fromCoordinate: startCoordinate, toCoordinate: endCoordinate, player: currentPlayerTurn)

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
        }
    }

    public func gameOver() -> Bool {
        return (boardGame.player1.numberPiecesOnBoard < 3 || boardGame.player2.numberPiecesOnBoard < 3)
    }
}