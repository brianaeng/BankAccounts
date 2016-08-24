require 'csv'

module Bank
  class Account
    attr_accessor :id, :balance, :open_date, :accounts, :account_hash

    def initialize(account_hash)
      @id = account_hash[:id]
      @balance = account_hash[:balance]
      @open_date = account_hash[:open_date]
      unless @balance >= 0
        raise ArgumentError.new("A new account cannot be created with a negative balance.")
      end
    end

    def self.all
      @@accounts = []

      account_hash = {}

      CSV.open("support/accounts.csv", "r").each do |line|
        account_hash[:id] = line[0].to_i
        account_hash[:balance] = (line[1].to_f)/100
        account_hash[:open_date] = line[2]
        @@accounts << Account.new(account_hash)
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
    def initialize(id, last_name, first_name, address, city, state)
      @id = id
      @last_name = last_name
      @first_name = first_name
      @address = address
      @city = city
      @state = state

      puts "Welcome, #{@name}. Below is your account information.
      Name: #{@name}
      Address: #{@address}"
    end

    def self.all



    end

  end
end

testing3 = Bank::Account.all
# print testing3
Bank::Account.find(1214)

# testing = Bank::Owner.new("testing", "testing address")
# testing2 = Bank::Account.new(testing, 100)
# testing2.get_balance
# testing2.deposit(100)
# testing2.withdraw(10)
# testing2.get_balance

Add the following class methods to your existing Owner class

self.all - returns a collection of Owner instances, representing all of the Owners described in the CSV. See below for the CSV file specifications
self.find(id) - returns an instance of Owner where the value of the id field in the CSV matches the passed parameter


To create the relationship between the accounts and the owners use the account_owners CSV file. The data for this file, in order in the CSV, consists of: Account ID - (Fixnum) a unique identifier corresponding to an account Owner ID - (Fixnum) a unique identifier corresponding to an owner
