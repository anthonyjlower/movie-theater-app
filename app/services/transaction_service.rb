class TransactionService
	def get_all_transactions
		Transaction.all.includes(:showing).map do |transaction|
			showing = transaction.showing
			movie = showing.movie

			resp ={
				transaction: transaction,
				showing: showing,
				movie: movie
			}
		end
	end
end
