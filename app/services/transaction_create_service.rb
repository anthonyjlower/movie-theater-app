class TransactionCreateService
  attr_accessor :email, :first_name, :last_name, :showing_id, :quantity

  def initialize(args = {})
    @email = args[:email]
    @first_name = args[:first_name]
    @last_name = args[:last_name]
    @showing_id = args[:showing_id]
    @quantity = args[:quantity]
  end

  def create
    @transaction = Transaction.create(
      email: email,
      first_name: first_name,
      last_name: last_name,
      showing_id: showing_id,
      quantity: quantity,
      cost: calc_cost
    )
  end

  private

  def calc_cost
    Showing.find(showing_id).price * BigDecimal(quantity)
  end
end
