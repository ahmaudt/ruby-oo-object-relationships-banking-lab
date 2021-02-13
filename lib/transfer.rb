require 'pry'
require_relative './bank_account.rb'

class Transfer
  attr_accessor :sender, :receiver, :amount, :status
  
  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = "pending"
  end

  def valid?
    @receiver.valid? && @sender.valid? #! we set require_relative for banking file, so we can use methods for corresponding objects
    
  end
  # binding.pry

  def execute_transaction
    # binding.pry
    if self.status == "pending" && self.valid? == true && @sender.balance > @amount
      @receiver.deposit(@amount) && @sender.deposit(@amount*-1)
      self.status = "complete"
    else
      @status = "rejected"
      "Transaction rejected. Please check your account balance."
    end
  end

  def reverse_transfer
    if self.status == "complete"
      @receiver.deposit(@amount*-1) && @sender.deposit(@amount)
      self.status = "reversed"
    end
  end
end
