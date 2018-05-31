class DashboardService
	class << self

		def total_rev
			total_rev = 0
			Transaction.all.find_each do |trans|
				total_rev += trans.cost
			end
			total_rev
		end

		def daily_sales
			daily_sales = {}

			Transaction.all.find_each do |trans|
				date = get_weekday(trans.showing.date.wday)
				daily_sales.has_key?(date) ? daily_sales[date] += trans.cost : daily_sales[date] = trans.cost
			end
			daily_sales
		end

			
		def hourly_sales
			hourly_sales = {}

			Transaction.all.find_each do |trans|
				time = trans.showing.time
				hourly_sales.has_key?(time) ? hourly_sales[time] += trans.cost : hourly_sales[time] = trans.cost
			end
			hourly_sales
		end

		def movie_sales
			movie_sales = {}

			Movie.all.find_each do |movie|
				ticket_sales = 0

				movie.transactions.find_each do |trans|
					ticket_sales += trans.cost
				end

				movie_sales[movie.title] = {
					id: movie.id,
					title: movie.title,
					sales: ticket_sales
				}
			end
			movie_sales
		end




		def get_weekday date
			Date::DAYNAMES[date]			
		end


	end
end