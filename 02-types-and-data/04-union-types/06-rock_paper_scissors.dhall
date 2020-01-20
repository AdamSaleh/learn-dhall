let Hand = <Rock | Paper | Scissors >
let Result = <First| Second| Draw >
let wins = \(players : {first : Hand, second : Hand})
  -> merge { Rock = merge {Rock = Result.Draw, Paper = Result.Second, Scissors = Result.First} players.second 
           , Paper = merge {Rock = Result.First, Paper = Result.Draw, Scissors = Result.Second} players.second
           , Scissors = merge {Rock = Result.Second, Paper = Result.First, Scissors = Result.Draw} players.second } players.first 
let example = assert : wins {first = Hand.Rock, second = Hand.Paper} === Result.Second
in wins {first = Hand.Rock, second = Hand.Paper}
  