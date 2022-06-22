class Hangman
  DICTIONARY = ["cat", "dog", "bootcamp", "pizza"]

  def self.random_word
    DICTIONARY.sample
  end

  def initialize()
    @secret_word = Hangman.random_word
    @guess_word = Array.new(@secret_word.length, "_")
    @attempted_chars = []
    @remaining_incorrect_guesses = 5
  end

  def guess_word
    @guess_word
  end

  def attempted_chars
    @attempted_chars
  end

  def remaining_incorrect_guesses
    @remaining_incorrect_guesses
  end

  def already_attempted?(char)
    return true if @attempted_chars.include?(char)
    return false if !@attempted_chars.include?(char)
  end

  def get_matching_indices(char)
    indices = []
    @secret_word.each_char.with_index do |ch, i|
      if ch == char
        indices << i
      end
    end

    return indices
  end

  def fill_indices(char, indices)
    indices.each do |idx|
      @guess_word[idx] = char
    end
  end

  def try_guess(char)
    if !@secret_word.include?(char)
      @remaining_incorrect_guesses -= 1
    end

    matching_indices = self.get_matching_indices(char)
    self.fill_indices(char, matching_indices)

    if self.already_attempted?(char)
      puts "that has already been attempted"
      return false
    else
      @attempted_chars << char
      return true
    end
  end

  def ask_user_for_guess
    puts "Enter a char:"
    char = gets.chomp
    return self.try_guess(char)
  end

  def win?
    if @guess_word.join("") == @secret_word
      puts "WIN"
      return true
    else
      return false
    end
  end

  def lose?
    if @remaining_incorrect_guesses == 0
      puts "LOSE"
      return true
    else
      return false
    end
  end

  def game_over?
    if self.win? || self.lose?
      puts @secret_word
      return true
    else
      return false
    end
  end
end
