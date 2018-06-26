class DashboardService
	attr_reader :transactions

	def initialize
		@transactions = Transaction.includes(showing: :movie).all
	end

	def total_rev
		@transactions.sum(:cost)
	end

	def daily_sales
		sales = @transactions.group_by do |t|
			get_weekday(t.showing.date.wday)
		end
		calculate(sales)
	end

	def hourly_sales
		sales = @transactions.group_by do |t|
			t.showing.time
		end
		calculate(sales)
	end

	def movie_sales
		sales = @transactions.group_by do |t|
			t.showing.movie.title
		end
		calculate(sales)
	end

	private

	def get_weekday(date)
		Date::DAYNAMES[date]
	end

	def calculate(hash_obj)
		hash_obj.each_pair do |key, value|
			hash_obj[key] = {
				sales: value.pluck(:cost).sum,
				id: value[0].showing.movie.id
			}
		end
	end
end
