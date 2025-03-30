#!/usr/bin/ruby

def hangman ()

  masked_letters = Array.new
  wrong_guesses = Array.new
  right_guesses = Array.new
  
  words = File.readlines("words.txt")
  word = words[rand(words.size)].strip
  word_letters = word.split ''

  word_letters.each { |_| masked_letters.push "_" } 
  chances = (word.size + 2)
  
  intro()
  while chances > 0
    
    system "clear"
    if word_letters == masked_letters
      puts "'#{word}' was the word."
      puts green "You win!"
      exit
    end

    title()
    puts "The word is #{masked_letters.join(' ')}"
    puts "Guesses: #{wrong_guesses}"
    puts "Chances: #{chances}"
    puts "\nEnter guess ..."
    
    guess = gets.chomp
    if not (guess.size == 1)
      print red "Please only type one letter!"
      sleep 1
      next
    end
    
    if (wrong_guesses.include? guess) or (right_guesses.include? guess)
      print red "Already guessed!"
      sleep 1
      next
    else
      if word_letters.include? guess
        right_guesses.push guess
        word_letters.map.with_index { |v, i|
          if v == guess
            masked_letters[i] = guess
          end 
        }
      else
        chances -= 1
        wrong_guesses.push guess
      end
    end
  end
  
  puts "\nThe word was '#{word}'"
  puts red "You lose!"

end

def red (word)
  return "\033[31m#{word}\033[37m"
end

def green (word)
  return "\033[32m#{word}\033[37m"
end

def title ()
  puts red "RUBY HANGMAN"
  puts "\n\n"
end

def intro ()
  system "clear"
  (red "RUBY HANGMAN").split('').each do |c|
    print c
    sleep 0.03
  end
end



hangman()
