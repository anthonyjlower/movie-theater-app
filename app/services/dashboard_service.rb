class DashboardService
	attr_reader :transactions

	def initialize
		@transactions = Transaction.all.includes(:showing)
	end

	def total_rev
		@transactions.each.pluck(:cost).sum
	end

	def daily_sales
		daily_sales = {}
		@transactions.each do |trans|
			date = get_weekday(trans.showing.date.wday)
			calculate(daily_sales, date, trans.cost)
		end
		daily_sales
	end

	def hourly_sales
		hourly_sales = {}
		@transactions.each do |trans|
			time = trans.showing.time
			calculate(hourly_sales, time, trans.cost)
		end
		hourly_sales
	end

	def movie_sales
		movie_sales = {}
		Movie.all.find_each do |movie|
			movie_sales[movie.title] = {
				id: movie.id,
				title: movie.title,
				sales: movie.transactions.pluck(:cost).sum
			}
		end
		movie_sales
	end

	private

	def get_weekday(date)
		Date::DAYNAMES[date]
	end

	def calculate(hash_obj, key, sum)
		if hash_obj[key].nil?
			hash_obj[key] = sum
		else
			hash_obj[key] += sum
		end
	end
end
