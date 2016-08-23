module Bank
  class Account
    attr_accessor :balance, :withdraw_amount, :deposit_amount, :answer

    def initialize
      #Creates new account owner
      Owner.new

      #Calls get_balance
      get_balance

      #Calls give_choices
      give_choices
    end

    #Asks user what type of transaction they'd like to do & calls corresponding method (if any)
    def give_choices
      puts "\nWhat would you like to do today?
      | 1 | Withdraw money
      | 2 | Deposit money
      | 3 | Check balance
      | 4 | Exit"

      choice = gets.chomp.upcase

      case choice
      when "1", "WITHDRAW", "WITHDRAW MONEY"
        puts "You chose withdraw. How much would you like to withdraw?"
        withdraw_amount = gets.chomp.to_f
        @withdraw_amount = withdraw_amount
        withdraw(withdraw_amount)
      when "2", "DEPOSIT", "DEPOSIT MONEY"
        puts "You chose deposit. How much would you like to deposit?"
        deposit_amount = gets.chomp.to_f
        @deposit_amount = deposit_amount
        deposit(deposit_amount)
      when "3", "CHECK BALANCE", "CHECK"
        puts "You chose to check your balance. Your current balance is #{@balance}."
      when "4", "EXIT"
        puts "Thank you for choosing E-Corp Bank."
      else
        puts "Error, invalid input. Please try again."
        give_choices
      end

      #Calls ask_again method
      ask_again
    end

    #Method to allow the loop for additional transactions
    def ask_again
      @answer = nil
      until @answer == "NO" || @answer == "YES"
        print "Would you like to do another transaction? (YES/NO) "
        @answer = gets.chomp.upcase
        if @answer == "YES"
          give_choices
        elsif @answer == "NO"
          puts "Thank you for choosing E-Corp Bank."
        else
          puts "Error, invalid input. Please try again."
          ask_again
        end
      end
    end

    #Obtains user's starting balance & raises ArgumentError if negative
    def get_balance
      puts "\nWhat is your starting balance? "
      @balance = gets.chomp.to_f
      unless @balance >= 0
        raise ArgumentError.new("A new account cannot be created with a negative balance.")
      end
    end

    #Method to withdraw money (& checks if amount is too high)
    def withdraw(withdraw_amount)
      if @balance < withdraw_amount
        puts "There is not enough money in your account to withdraw that amount. Your balance is #{@balance}. Please enter a new withdraw amount. "
        withdraw_amount = gets.chomp.to_f
      else
        @balance -= withdraw_amount
        puts "You withdrew #{withdraw_amount}. Your new balance is #{@balance}."
      end
    end

    #Method to depoosit money (& checs if amount is negative)
    def deposit(deposit_amount)
      if deposit_amount < 0
        puts "Invalid deposit amount entered. Please enter a new deposit amount. "
        deposit_amount = gets.chomp.to_f
      else
        @balance += deposit_amount
        puts "You deposited #{deposit_amount}. Your new balance is #{@balance}."
      end
    end

  end

  class Owner
    def initialize
      puts "Welcome to E-Corp Bank. To open an account, we require some information."

      #Calls get_info method
      get_info

      id = rand(111111..999999)

      puts "\nWelcome to your new account at E-Corp, #{@name}. Your ID is #{id}."
    end

    #Method to obtain user account information
    def get_info
      print "Please enter your full name: "
      name = gets.chomp.upcase
      @name = name
      print "Please enter your full address: "
      address = gets.chomp.upcase
      @address = address

      #Calls check_info method
      check_info
    end

    #Method to double-check if user input was correct
    def check_info
      puts "\nHere's the account information you submitted
      Name: #{@name}
      Address: #{@address}"

      answer2 = nil
      until answer2 == "YES" || answer2 == "NO"
      puts "Is this information correct? (YES/NO)"
      answer2 = gets.chomp.upcase
        if answer2 == "NO"
          puts "You indicated that the information was incorrect. Please re-enter your account information."
          get_info
        elsif answer2 == "YES"
          puts "Thank you for verifying the information."
        else
          puts "Please try again. Is the above information correct?"
          answer2 = gets.chomp.upcase
        end
      end
    end
  end

end

Bank::Account.new
