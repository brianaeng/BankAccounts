module Bank
  class Account
    attr_accessor :balance

    def initialize(owner, balance)
      @balance = balance
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

    def get_balance
      puts "Your balance is #{@balance}."
    end

  end

  class Owner
    def initialize(name, address)
      @name = name
      @address = address
      @id = rand(111111..999999)

      puts "Welcome, #{@name}. Below is your account information.
      Name: #{@name}
      Address: #{@address}
      ID: #{@id}"
    end
  end
end

testing = Bank::Owner.new("testing", "testing address")
testing2 = Bank::Account.new(testing, 100)
testing2.get_balance
testing2.deposit(100)
testing2.withdraw(10)
testing2.get_balance
