require "rspec"

require_relative "account"

describe Account do

  let(:acct_number) { '1234567890' }
  let(:account) { Account.new(acct_number) }

  describe "#initialize" do
    context "with valid input" do
      it "creates a new Account of the specified type" do
        expect(account).to be_a_kind_of(Account)
      end

      it "expect to accept 2 input" do
        expect {Account.new(acct_number, 100)}.not_to raise_error
      end
    end

    context "with invalid input" do
      it "throws an argument error when not given a type argument" do
        expect { Account.new }.to raise_error(ArgumentError)
      end

      it "throws invalid account number error when given a wrong type of argument" do
        expect {Account.new("abc")}.to raise_error(InvalidAccountNumberError)
        expect {Account.new("123")}.to raise_error(InvalidAccountNumberError)
      end
    end
  end

  describe "#transactions" do
    it "value [0] when initialize" do
      expect(account.transactions).to eq [0]
    end

    context "after deposit and withdraw" do
      it "add transaction after deposit and withdraw" do
        account.deposit!(50)
        expect(account.transactions).to eq [0, 50]
        account.withdraw!(25)
        expect(account.transactions).to eq [0, 50, -25]
      end
    end
  end

  describe "#balance" do
    it "starting balance should be 0" do
      expect(account.balance).to eq 0
    end
  end

  describe "#account_number" do
    it "expect only show last 4 digit of account number" do
      expect(account.acct_number).to eq "******7890"
    end
  end

  describe "deposit! & withdraw!" do
    context "after deposit and withdraw" do
      it "increase balance after deposit and decrease after withdraw" do
        expect(account.deposit!(100)).to eq 100
        expect(account.withdraw!(50)).to eq 50
      end

      it "raise negative deposit error when deposit is negative" do
        expect {account.deposit!(-100)}.to raise_error(NegativeDepositError)
      end

      it "raise overdraft error if withdraw amount is more than balance" do
        expect {account.withdraw!(50)}.to raise_error(OverdraftError)
      end
    end
  end
end