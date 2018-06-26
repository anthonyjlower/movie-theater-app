module Seeds
  class Seeder
    class << self

      NUM_MOVIES = 3
      NUM_OF_SHOWINGS = 30
      NUM_OF_TRANSACTIONS = 10
      SHOWING_TIMES = ['12:30 PM', '3:00 PM', '5:30 PM', '8:00 PM', '10:30 PM']

      def seed
        puts 'cleaning db...'
        clean_db
        puts 'creating movies...'
        create_movies
        puts 'creating showings...'
        create_showings
        puts 'creating transactions...'
        create_transactions
        puts 'seeding complete'
        puts "creates #{NUM_MOVIES} movies, #{Showing.all.count} showings, and #{Transaction.all.count} transactions"
      end

      private

      def clean_db
        tables.each { |table| table.constantize.destroy_all }
      end

      def tables
        %w(Transaction Showing Movie)
      end

      def create_movies
        movies = NUM_MOVIES.times.map do |i|
          {
            title: Faker::Book.title
          }
        end
        Movie.create(movies)
      end

      def create_showings
        showings = Movie.all.map do |movie|
          SHOWING_TIMES.length.times.map do |i|
            {
              date: Faker::Date.between(Date.new(2018, 4, 12), Date.new(2018, 4, 17)),
              time: SHOWING_TIMES[i],
              capacity: Faker::Number.between(50, 100),
              price: Faker::Number.between(5, 15),
              movie_id: movie.id
            }
          end
        end
        Showing.create(showings.flatten)
      end

      def create_transactions
        transactions = Showing.all.map do |showing|
          Array.new(NUM_OF_SHOWINGS) do
            quant = Faker::Number.between(1, 3)
            {
              quantity: quant,
              email: Faker::Internet.email,
              first_name: Faker::Name.first_name,
              last_name: Faker::Name.last_name,
              cost: showing.price * quant,
              showing_id: showing.id
            }
          end
        end
        Transaction.create(transactions.flatten)
      end
    end
  end
end
