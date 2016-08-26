require 'csv'

module Bank
  class Account
    attr_accessor :id, :balance, :open_date, :accounts, :fee, :limit

    #Initializes basic account attributes (initialized fee & limit used in other classes)
    def initialize(account_hash)
      @id = account_hash[:id]
      @balance = account_hash[:balance]
      @open_date = account_hash[:open_date]
      @fee = 0
      @limit = 0

      #Gives error if balance is negative
      unless @balance >= 0
        raise ArgumentError.new("A new account cannot be created with a negative balance.")
      end
    end

    #Class method to create & store accounts from the csv file
    def self.all
      @@accounts = []

      CSV.open("support/accounts.csv", "r").each do |line|
        account_hash = {}
        account_hash[:id] = line[0].to_i
        account_hash[:balance] = (line[1].to_f)/100
        account_hash[:open_date] = line[2]
        @@accounts << Account.new(account_hash)
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
      if (balance - withdraw_amount - fee) < limit
        return "There is not enough money in your account to withdraw that amount."
      else
        @balance -= (withdraw_amount + fee)
        puts "You withdrew #{withdraw_amount}"
      end
      return balance
    end

    #Instance method to depoosit money (& checs if amount is negative)
    def deposit(deposit_amount)
      if deposit_amount < 0
        return "Invalid deposit amount entered."
      else
        @balance += deposit_amount
        puts "You deposited #{deposit_amount}. "
      end
      return balance
    end

    #Instance method to show balance
    def get_balance
      return balance
    end

    #Instance method to cleanly display account attributes
    def show
      return "
      ID: #{id}
      Balance: #{balance}
      Date: #{open_date}"
    end

  end

  class SavingsAccount < Account
    attr_accessor :interest

    #initializes info inherited from Account class, overrides fee & limit, and adds new warning
    def initialize(account_hash)
      super
      @fee = 2
      @limit = 10
      unless @balance > 10
        raise ArgumentError.new("A new account cannot be created with less than $10.")
      end
    end

    #Instance method to return interest rate
    def add_interest(rate)
      @interest = balance * (rate/100)
      @balance += interest
      return interest
    end

  end

  class CheckingAccount < Account
    attr_accessor :checks

    #Initializes info inherited from Account class, overrides fee & limit, and adds checks instance variable
    def initialize(account_hash)
      super
      @checks = 0
      @fee = 1
      @limit = 0
    end

    #Instance method for check withdrawal
    def withdraw_using_check(amount)
      if @checks < 3
        if (@balance - amount) < -10
          puts "You cannot go into overdraft beyond -$10."
        else
          @balance -= amount
        end
      else
        if (@balance - amount - 2) < -10
          puts "You cannot go into overdraft beyond -$10."
        else
          @balance -= (amount + 2)
        end
      end

      @checks += 1
      return balance

    end

    #Instance method to reset check count
    def reset_checks
      @checks = 0
    end

  end

  class Owner
    attr_accessor :owners, :id, :last_name, :first_name, :address, :city, :state

    #Initializes basic owner information
    def initialize(owner_hash)
      @id = owner_hash[:id]
      @last_name = owner_hash[:last_name]
      @first_name = owner_hash[:first_name]
      @address = owner_hash[:address]
      @city = owner_hash[:city]
      @state = owner_hash[:state]
    end

    #Class method to create & store owner profiles from the csv file
    def self.all
      @@owners = []

      CSV.open("support/owners.csv", "r").each do |line|
        owner_hash = {id: line[0].to_i, last_name: line[1], first_name: line[2], address: line[3], city: line[4], state: line[5]}
        @@owners << Owner.new(owner_hash)
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
      return "
      ID: #{id}
      Last Name: #{last_name}
      First Name: #{first_name}
      Address: #{address}
      City: #{city}
      State: #{state}"
    end

  end

end


###ACCOUNT CLASS###

# #Testing instance methods on an initialized account
# testing1 = Bank::Account.new(id: 00000, balance: 100, open_date: "test")
# puts testing1.get_balance
# puts testing1.deposit(100)
# puts testing1.withdraw(10)
# puts testing1.get_balance

# #Test self.all method for Account class
# testing2 = Bank::Account.all
# print testing2
#
# #Test to see if instance methods work on accounts using self.all
# testing2[0].get_balance
#
# #Test self.find method for Account class
# puts Bank::Account.find(1214).show


###SAVINGSACCOUNT CLASS###

# #Test SavingsAccount and its methods
# testing5 = Bank::SavingsAccount.new(id: 8439545, balance: 21, open_date: "today")
# puts testing5.withdraw(1)
# puts testing5.withdraw(1)
# puts testing5.deposit(1)
# puts testing5.withdraw(1)
# puts testing5.withdraw(1)
# puts testing5.withdraw(1)
# puts testing5.add_interest(0.25)


###CHECKINGACCOUNT CLASS###

# #Test CheckingAccount and its methods
# testing6 = Bank::CheckingAccount.new(id: 395435, balance: 11, open_date: "yesterday")
# puts testing6.withdraw(1)
# puts testing6.withdraw(2)
# puts testing6.deposit(1)
# puts testing6.withdraw_using_check(3)
# puts testing6.withdraw_using_check(1)
# puts testing6.withdraw_using_check(1)
# puts testing6.withdraw_using_check(1)
# testing6.reset_checks
# puts testing6.withdraw_using_check(10)
# puts testing6.withdraw_using_check(3)
# puts testing6.withdraw_using_check(1)

###OWNER CLASS###

# #Test self.all method for Owner class
# Bank::Owner.all
#
# #Test self.find method for Owner class
# puts Bank::Owner.find(16).show
