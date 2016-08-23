module Bank
  class Account
    attr_accessor :balance, :withdraw_amount, :deposit_amount

    def initialize
      get_balance

      @id = rand(111111..999999)
      puts "\nThank you for creating a new account at E-Corp, your ID is #{@id}."

      give_choices
    end

    def give_choices
      puts "\nWhat would you like to do today?
      1 | Withdraw money
      2 | Deposit money
      3 | Check balance
      4 | Exit"

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
      end

      ask_again
    end

    def ask_again
      answer = nil
      until answer == "NO" || answer == "YES"
        print "Would you like to do another transaction? (YES/NO) "
        answer = gets.chomp.upcase
        if answer == "YES"
          give_choices
        else
          puts "Thank you for choosing E-Corp Bank."
        end
      end
    end

    def get_balance
      puts "What is your starting balance? "
      @balance = gets.chomp.to_f
      unless @balance >= 0
        raise ArgumentError.new("A new account cannot be created with a negative balance.") #FIX THIS
      end
    end

    def withdraw(withdraw_amount)
      if @balance < withdraw_amount
        puts "There is not enough money in your account to withdraw that amount. Your balance is #{@balance}. Please enter a new withdraw amount. "
        withdraw_amount = gets.chomp.to_f
      else
        @balance -= withdraw_amount
        puts "You withdrew #{withdraw_amount}. Your new balance is #{@balance}."
      end
    end

    def deposit(deposit_amount)
      if @deposit_amount < 0
        puts "Invalid deposit amount entered. Please enter a new deposit amount. "
        @deposit_amount = gets.chomp.to_f
      else
        @balance += @deposit_amount
        puts "You deposited #{@deposit_amount}. Your new balance is #{@balance}."
      end
    end

  end
end

Bank::Account.new
