require 'csv'

module Bank
  class Account
    attr_accessor :id, :balance, :open_date, :accounts

    #Initializes basic account attributes
    def initialize(id, balance, open_date)
      @id = id
      @balance = balance
      @open_date = open_date

      #Gives error if balance is negative
      unless @balance >= 0
        raise ArgumentError.new("A new account cannot be created with a negative balance.")
      end
    end

    #Class method to create & store accounts from the csv file
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

    #Class method to find a certain account by its id
    def self.find(id)
      @@accounts.each do |account|
        if account.id == id
          return account
        end
      end
    end

    #Instance method to withdraw money (& checks if amount is too high)
    def withdraw(withdraw_amount)
      if @balance < withdraw_amount
        puts "There is not enough money in your account to withdraw that amount."
      else
        @balance -= withdraw_amount
        puts "You withdrew #{withdraw_amount}."
      end
      return balance
    end

    #Instance method to depoosit money (& checs if amount is negative)
    def deposit(deposit_amount)
      if deposit_amount < 0
        puts "Invalid deposit amount entered."
      else
        @balance += deposit_amount
        puts "You deposited #{deposit_amount}. Your new balance is #{balance}."
      end
    end

    #Instance method to show balance
    def get_balance
      puts "Your balance is #{balance}."
    end

    #Instance method to cleanly display account attributes
    def show
      puts "
      ID: #{id}
      Balance: #{balance}
      Date: #{open_date}"
    end

  end

  class SavingsAccount < Account
    attr_accessor :interest

    def initialize(id, balace, open_date)
      super
      unless @balance > 10
        raise ArgumentError.new("A new account cannot be created with less than $10.")
      end
    end

    def withdraw(withdraw_amount)
      if @balance < (withdraw_amount + 2)
        puts "There is not enough money in your account to withdraw that amount."
      elsif (@balance - withdraw_amount) < 8
        puts "Unable to make withdrawal because your account cannot go below $10."
      else
        @balance -= (withdraw_amount + 2)
      end
      return balance
    end

    def add_interest(rate)
      @interest = @balance * (rate/100)
      @balance += interest
      return interest
    end

  end

  class CheckingAccount < Account
    attr_accessor :checks

    def withdraw(withdraw_amount)
      if @balance < (withdraw_amount + 1)
        puts "There is not enough money in your account to withdraw that amount."
      else
        @balance -= (withdraw_amount + 1)
      end
      return balance
    end

    def withdraw_using_check(amount)
      @@checks = 3

      until @@checks <= 0
        @@checks -= 1
        if @balance < (amount - 10)
          puts "You cannot go into overdraft beyond -$10."
        else
          @balance -= amount
        end
        puts "TEST #{@@checks}"
        return balance
      end

      if @balance < (amount - 10)
        puts "You cannot go into overdraft beyond -$10."
      else
        @balance -= (amount + 2)
      end
      return balance

    end

  end

  class Owner
    attr_accessor :owners, :id, :last_name, :first_name, :address, :city, :state

    #Initializes basic owner information
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

    #Class method to create & store owner profiles from the csv file
    def self.all
      @@owners = []

      CSV.open("support/owners.csv", "r").each do |line|
        @@owners << Owner.new(line[0].to_i, line[1], line[2], line[3], line[4], line[5])
      end

      return @@owners
    end

    #Class method to find a certain owner profile by its id
    def self.find(id)
      @@owners.each do |owner|
        if owner.id == id
          return owner
        end
      end
    end

    #Instance method to cleanly display owner attributes
    def show
      puts "
      ID: #{id}
      Last Name: #{last_name}
      First Name: #{first_name}
      Address: #{address}
      City: #{city}
      State: #{state}"
    end

  end

end

#Test SavingsAccount
testing5 = Bank::CheckingAccount.new(8439545, 10, "today")
puts testing5.withdraw_using_check(1)
puts testing5.withdraw_using_check(1)
puts testing5.withdraw_using_check(1)
puts testing5.withdraw_using_check(1)
puts testing5.withdraw_using_check(1)




# #Test self.all method for account class
# testing3 = Bank::Account.all
# print testing3
#
# #Test self.find method for account class
# Bank::Account.find(1214).show
#
# #Test self.all method for owner class
# Bank::Owner.all
#
# #Test self.find method for owner class
# Bank::Owner.find(16).show
#
# #Test to see if instance methods work on new additions
# testing3[0].get_balance
#
#
# #Testing instance methods on an initialized account
# testing2 = Bank::Account.new(00000, 100, "test")
# testing2.get_balance
# testing2.deposit(100)
# testing2.withdraw(10)
# testing2.get_balance

# def self.link_owner
#   counter = 0
#
#   CSV.open("support/account_owners.csv", "r+") do |line|
#     # if @@owners[counter].id.to_s == line[1]
#     #     # line += (owner.shift)
#     # end
#     @@owners.each do |owner|
#       if line.include? owner.id.to_s
#         print owner
#       end
#     end
#     # if line.include?
#     # @@owners.each do |owner|
#     #   if owner.id.to_s == line[1]
#     #     line << [owner.last_name, owner.first_name, owner.address, owner.city, owner.state]
#     #   end
#     # end
#   end
# end
