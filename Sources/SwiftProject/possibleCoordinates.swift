struct Coordinates : Equatable, Hashable {
    var row: Int
    var column: Character

    init(row: Int, column: Character) {
       self.row = row
       self.column = column
    }

    static func == (lhs: Coordinates, rhs: Coordinates) -> Bool {
        return (lhs.row == rhs.row && lhs.column == rhs.column)
    }
}

// Big circle
let A1 = Coordinates(row: 1, column: "A")
let A4 = Coordinates(row: 4, column: "A")
let A7 = Coordinates(row: 7, column: "A")
let D1 = Coordinates(row: 1, column: "D")
let G1 = Coordinates(row: 1, column: "G")
let D7 = Coordinates(row: 7, column: "D")
let G7 = Coordinates(row: 7, column: "G")
let G4 = Coordinates(row: 4, column: "G")

//Middle circle
let B2 = Coordinates(row: 2, column: "B")
let B4 = Coordinates(row: 4, column: "B")
let B6 = Coordinates(row: 6, column: "B")
let D2 = Coordinates(row: 2, column: "D")
let F2 = Coordinates(row: 2, column: "F")
let D6 = Coordinates(row: 6, column: "D")
let F6 = Coordinates(row: 6, column: "F")
let F4 = Coordinates(row: 4, column: "F")

//Little circle
let C3 = Coordinates(row: 3, column: "C")
let E3 = Coordinates(row: 3, column: "E")
let D3 = Coordinates(row: 3, column: "D")
let C4 = Coordinates(row: 4, column: "C")
let C5 = Coordinates(row: 5, column: "C")
let D5 = Coordinates(row: 5, column: "D")
let E4 = Coordinates(row: 4, column: "E")
let E5 = Coordinates(row: 5, column: "E")

let coordArray: [Coordinates] = [A1, A4, A7, D1, G1, D7, G7, G4, 
                                 B2, B4, B6, D2, F2, D6, F6, F4, 
                                 C3, E3, D3, C4, C5, D5, E5, E4]

// mill combinations for every position
let millCombination: [Coordinates : [[Coordinates]]] = 
                     [A1 : [[D1, G1], [A4, A7]], 
                      A4 : [[A1, A7], [B4, C4]],
                      A7 : [[A1, A4], [D7, G7]],
                      D1 : [[A1, G1], [D2, D3]],
                      G1 : [[A1, D1], [G4, G7]],
                      G4 : [[G1, G7], [F4, E4]],
                      G7 : [[D7, A7], [G4, G1]],
                      D7 : [[A7, G7], [D6, D5]],
                      B2 : [[D2, F2], [B4, B6]],
                      B4 : [[B2, B6], [A4, C4]],
                      B6 : [[B2, B4], [D6, F6]],
                      F6 : [[D6, B6], [F4, F2]],
                      F4 : [[F2, F6], [E4, G4]],
                      F2 : [[B2, D2], [F4, F6]],
                      D2 : [[D1, D3], [B2, F2]],
                      D6 : [[D5, D7], [B6, F6]],
                      C3 : [[C4, C5], [D3, E3]],
                      C4 : [[C3, C5], [B4, A4]],
                      C5 : [[C4, C3], [D5, E5]],
                      E5 : [[D5, C5], [E3, E4]],
                      E4 : [[F4, G4], [E3, E5]],
                      E3 : [[D5, C5], [D3, C3]],
                      D3 : [[D2, D1], [E3, C3]],
                      D5 : [[C5, E5], [D6, D7]]]
                 