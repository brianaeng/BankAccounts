require 'csv'

module Bank
  class Account
    attr_accessor :id, :balance, :open_date, :accounts

    def initialize(id, balance, open_date)
      @id = id
      @balance = balance
      @open_date = open_date
      unless @balance >= 0
        raise ArgumentError.new("A new account cannot be created with a negative balance.")
      end
    end

    def self.all
      @@accounts = []

      CSV.open("support/accounts.csv", "r").each do |line|
        account_id = line[0].to_i
        account_balance = (line[1].to_f)/100
        account_date = line[2]
        @@accounts << Account.new(account_id, account_balance, account_date)
      end

      return @@accounts
    end

    def self.find(id)
      @@accounts.each do |account|
        if account.id == id
          return account
        end
      end
    end

    #Method to withdraw money (& checks if amount is too high)
    def withdraw(withdraw_amount)
      if @balance < withdraw_amount
        puts "There is not enough money in your account to withdraw that amount. Your balance is #{@balance}. Please enter a new withdraw amount. "
        # withdraw_amount = gets.chomp.to_f
      else
        @balance -= withdraw_amount
        puts "You withdrew #{withdraw_amount}. Your new balance is #{@balance}."
      end
    end

    #Method to depoosit money (& checs if amount is negative)
    def deposit(deposit_amount)
      if deposit_amount < 0
        puts "Invalid deposit amount entered. Please enter a new deposit amount. "
        # deposit_amount = gets.chomp.to_f
      else
        @balance += deposit_amount
        puts "You deposited #{deposit_amount}. Your new balance is #{@balance}."
      end
    end

    def get_balance
      puts "Your balance is #{@balance}."
    end

    def show
      puts "
      ID: #{@id}
      Balance: #{@balance}
      Date: #{@open_date}"
    end

  end

  class Owner
    attr_accessor :owners, :id, :last_name, :first_name, :address, :city, :state
    def initialize(id, last_name, first_name, address, city, state)
      @id = id
      @last_name = last_name
      @first_name = first_name
      @address = address
      @city = city
      @state = state

      # puts "Welcome, #{@name}. Below is your account information.
      # Name: #{@name}
      # Address: #{@address}"
    end

    def self.all
      @@owners = []

      CSV.open("support/owners.csv", "r").each do |line|
        @@owners << Owner.new(line[0].to_i, line[1], line[2], line[3], line[4], line[5])
      end

      return @@owners
    end

    def self.find(id)
      @@owners.each do |owner|
        if owner.id == id
          return owner
        end
      end
    end

    def show
      puts "
      ID: #{@id}
      Last Name: #{@last_name}
      First Name: #{@first_name}
      Address: #{@address}
      City: #{@city}
      State: #{@state}"
    end

  end
  
end

# testing3 = Bank::Account.all
# print testing3
# Bank::Account.find(1214).show
testing4 = Bank::Owner.all
Bank::Owner.find(16).show



# testing2 = Bank::Account.new(00000, 100, "test")
# testing2.get_balance
# testing2.deposit(100)
# testing2.withdraw(10)
# testing2.get_balance
