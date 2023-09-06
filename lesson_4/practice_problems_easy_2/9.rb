class Game
  def play
    "Start the game!"
  end
end

class Bingo < Game
  def rules_of_play
    #rules of play
  end
end

# The new play method would override the Game class' play method. This is because according to the lookup chain, Ruby will look for a method of the name play in the Bingo class first
# and since it is found, it will not look for the play method in the Game class and so that one will not be invoked