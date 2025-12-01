import Algorithms

struct Day00: AdventDay {
    // Save your data in a corresponding text file in the `Data` directory.
    var data: String
    
    struct Command {
        enum Direction {
            case left
            case right
        }
        let direction: Direction
        let distance: Int
    }
    
    // Splits input data into its component parts and convert from string.
    var entities: [Command] {
        data.split(separator: "\n").map {
            let direction: Command.Direction = $0.first == "L" ? .left : .right
            return Command(direction: direction, distance: Int($0.dropFirst())!)
        }
    }
    
    func part1() -> Any {
        var currentPoint = 50
        var password = 0
        
        for entity in entities {
            switch entity.direction {
            case .left:
                currentPoint -= entity.distance
            case .right:
                currentPoint += entity.distance
            }
            
            currentPoint = (currentPoint % 100 + 100) % 100
            if currentPoint == 0 {
                password += 1
            }
        }
        return password
    }
    
    func part2() -> Any {
        var currentPoint = 50
        var password = 0
        
        for entity in entities {
            let prevPoint = currentPoint
            switch entity.direction {
            case .left:
                currentPoint -= entity.distance
            case .right:
                currentPoint += entity.distance
            }
            
            currentPoint = (currentPoint % 100 + 100) % 100
            
            switch entity.direction {
            case .left:
                if (prevPoint - entity.distance) < 0 {
                    if prevPoint != 0 {
                        password += (abs(prevPoint - entity.distance) / 100) + 1
                    } else {
                        password += abs(prevPoint - entity.distance) / 100
                    }
                }
                if (prevPoint - entity.distance) == 0 {
                    password += 1
                }
            case .right:
                password += (prevPoint + entity.distance) / 100
            }
        }
        return password
    }
}
