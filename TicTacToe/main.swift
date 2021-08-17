// Getting an appropriate integer input as a coordinate
func getCoordinate() -> Int {
  while true {
    if let input = readLine(), 
    let unwrappedInteger = Int(input),
    (1...3).contains(unwrappedInteger) {
      return unwrappedInteger
    } else {
      print("Incorrect input!")
      print("The number should be 1-3.")
      continue
    }
  }
}

// Printing the current grid
func printGrid(_ grid: [[String]]) {
  print(String(repeating: "\u{2b1b}", count: 5))
  print("\u{2b1b}\(grid[0][0])\(grid[0][1])\(grid[0][2])\u{2b1b}")
  print("\u{2b1b}\(grid[1][0])\(grid[1][1])\(grid[1][2])\u{2b1b}")
  print("\u{2b1b}\(grid[2][0])\(grid[2][1])\(grid[2][2])\u{2b1b}")
  print(String(repeating: "\u{2b1b}", count: 5))
}

// Getting info about the player's move and changing the grid
func getMove(_ grid: [[String]], _ player: String) -> [[String]] {
  while true {
    var changedGrid = grid

    print("Enter x:")
    let x = getCoordinate()
    print()
    print("Enter y:")
    let y = getCoordinate()

    let occupied = checkCell(x, y, grid)
    if occupied {
      print("\nThis cell is occupied! Choose another one!\n")
      continue
    }
    print()
    changedGrid[3 - y][x - 1] = player
    return changedGrid
  }
}

// Checking if the cell is occupied
func checkCell(_ x: Int, _ y: Int, _ grid: [[String]]) -> Bool {
  if (grid[3 - y][x - 1] == "\u{2b1c}") {
    return false
  }
  return true
}

// Checking if there is a winner or a draw
func checkResults(_ grid: [[String]]) -> String {
  let row1: String = grid[0][0] + grid[0][1] + grid[0][2]
  let row2: String  = grid[1][0] + grid[1][1] + grid[1][2]
  let row3: String  = grid[2][0] + grid[2][1] + grid[2][2]
  let col1: String  = grid[0][0] + grid[1][0] + grid[2][0]
  let col2: String  = grid[0][1] + grid[1][1] + grid[2][1]
  let col3: String  = grid[0][2] + grid[1][2] + grid[2][2]
  let diagonal1: String  = grid[0][0] + grid[1][1] + grid[2][2]
  let diagonal2: String  = grid[2][0] + grid[1][1] + grid[0][2]

  var xWins = false
  var oWins = false
  
  // Checking if X wins
  switch String(repeating: "\u{274c}", count: 3) {
    case row1, row2, row3, col1, col2, col3, diagonal1, diagonal2:
      xWins = true
      return "X wins"
    default:
      break
  }

  // Checking if O wins
  switch String(repeating: "\u{2b55}", count: 3) {
    case row1, row2, row3, col1, col2, col3, diagonal1, diagonal2:
      oWins = true
      return "O wins"
    default:
      break
  }

  // Checking if there is a draw
  var emptyCells = 9
    for i in 0...2 {
      for j in 0...2 {
        if (grid[i][j] == "\u{274c}" || grid[i][j] == "\u{2b55}") {
          emptyCells -= 1
        }
      }
    }
  if !xWins && !oWins && emptyCells == 0 {
    return "Draw"
  }
  return "Continuing"
}

// Getting "yes" or "no" from the user
func getYesOrNo() -> String {
  while true {
    let entered = readLine()!.lowercased()
    if "yes" == entered || "no" == entered {
      return entered
    }
    print("You should enter \"yes\" or \"no\".");
  }
}

// The game itself
while true {
  print("""
  \nCoordinates tip for the game:
  # # # # # # # # # # # #
  # |-----|-----|-----| #
  # | 1 3 | 2 3 | 3 3 | #
  # |-----|-----|-----| #
  # | 1 2 | 2 2 | 3 2 | #
  # | ----|-----|-----| #
  # | 1 1 | 2 1 | 3 1 | #
  # |-----|-----|-----| #
  # # # # # # # # # # # #\n
  """)

  // Creating the grid
  var grid = Array(repeating: Array(repeating: "\u{2b1c}", count: 3), count: 3)
  printGrid(grid)

  var ended = false
  var turn = 1
  var player = String()

  // The process of the game
  print("\nThe game begins!")
  while !ended {
    // Getting the player's turn
    if turn % 2 != 0 {
      player = "\u{274c}" // X player
      print("\n\u{274c}, your move!\n")
    } else {
      player = "\u{2b55}" // O player
      print("\n\u{2b55}, your move!\n")
    }

    // Getting a move and printing the changed grid
    grid = getMove(grid, player)
    printGrid(grid)

    // Checking if the game is over
    switch (checkResults(grid)) {
      case "X wins":
        print("\n\u{274c} wins! \u{2728}\u{1F3C6}\u{2728}")
        ended = true
      case "O wins":
        print("\n\u{2b55} wins! \u{2728}\u{1F3C6}\u{2728}")
        ended = true
      case "Draw":
        print("\nA draw! \u{1F91D}")
        ended = true
      default:
        break
    }
    turn += 1
  }

  // Asking if the players want to play again
  print("\nPlay again? Type yes / no.")
  if ("no" == getYesOrNo()) {
    print()
    break
  }
}
