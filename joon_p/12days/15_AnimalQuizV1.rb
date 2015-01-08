# Animal Quiz V1.0
# concept from ruby quizzes answer
# The program starts by telling the user to think of an animal. 
# It then begins asking a series of yes/no questions about that animal: does it swim, does it have hair, etc. 
# Eventually, it will narrow down the possibilities to a single animal and guess that (Is it a mouse?).

# If the program has guessed correctly, the game is over and may be restarted with a new animal. 
# If the program has guess incorrectly, it asks the user for the kind of animal they were thinking of 
# and then asks for the user to provide a question that can distinguish between its incorrect guess and the correct answer. 
# It then adds the new question and animal to its "database" and will guess that animal in the future (if appropriate).

# psuedocode
# 1. display a looping menu
# 2. initialize your first animal and an animal class 
# 3. after the first time through the animal class, ask the animals name, and request a question, answer, 
#  and pass these into the question class
# 4. create a binary tree with the question as the root > yes/no as the sub branches > and the animals as the leaves


require 'pry-byebug'


class Menu
  # handles screen output and refactoring decision trees.
  def self.ask?(question)
    p question
    input = gets.chomp.downcase
    if input == 'y'
      true
    elsif input == 'n'
      false
    else
      p 'Enter a valid input (y/n)'
      self.ask?(question)
    end
  end

end

class Animal
  attr_accessor :name
  # contains the animal attributes name
  # initializes with seeded animal
  def initialize(name)
    @name = name
  end

  def step
    if Menu.ask?("Is your animal a #{@name}?")
      p 'I win.'
      self
    else 
      p 'You win.'
      sleep(1)
      p 'What was the animal you were thinking of?'
      new_animal = gets.chomp.gsub(/\s+/, "_").downcase
      p "Give me a y/n question that would distinguish a #{new_animal} from a #{@name}"
      question = gets.chomp
      p 'What is the answer to your question? (y/n)'
      answer = gets.chomp.downcase
      if answer == 'y'
        Question.new(question, Animal.new(new_animal), self)
      elsif answer == 'n'
        Question.new(question, self, Animal.new(new_animal))
      end
    end
    
  end

end

class Question
  # contains question, answers
  # initializes with yes, no, question

  def initialize(question, yes, no)
    @yes = yes
    @no = no
    @question = question
    
  end

  def step
    
    p @question
    input = gets.chomp.downcase
    if input == 'y'
      @yes = @yes.step
    elsif input == 'n'
      @no = @no.step
    end
    self
  end
end




collect = Animal.new("mouse")


loop do
  #menu/game looping
  p 'Think of an Animal and I will guess it... Ready?'
  input = gets.chomp.downcase
  if input == 'y'
    collect = collect.step
  elsif input == 'n'
    exit
  else
    next
  end
  
end

