class HangpersonGame
  #partner: eric_cheng31 
  
  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses
  attr_accessor :word_with_guesses
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
    @word_with_guesses = '-' * word.length
  end

  def guess(letter)
    if !letter.respond_to?(:to_str) or !letter.match(/^[A-Za-z]/) 
      throw ArgumentError
    end  
    
    letter.downcase!
    
    if @guesses.include? letter or wrong_guesses.include? letter
        return false
    end
    
    if word.include? letter 
      @guesses << letter
      update_display
      return true
    else 
      @wrong_guesses << letter
      return true
    end
  end
  
  def update_display
    (0..@word.length-1).each do |i|
      if @guesses.include? @word[i]
        @word_with_guesses[i] = @word[i]
      else
        @word_with_guesses[i] = '-'
      end
    end
  end
  
  def check_win_or_lose
    if @guesses.length == @word.split('').uniq.length
      return :win
    elsif @wrong_guesses.length >= 7
      return :lose
    else 
      return :play
    end
  end
  
  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end

end
