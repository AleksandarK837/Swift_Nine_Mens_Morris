class Board {
    private var positions: [Position]
    let millsCombination = millCombination

    init() {
        positions = []
        for position in coordArray {
            positions.append(Position(coordinate: position))
        }
    }
    
    public subscript(coordinate: Coordinates) -> Position? {
        for pos in positions {
            if pos.coordinate == coordinate {
                return pos
            }
        }
        return nil
    }
}