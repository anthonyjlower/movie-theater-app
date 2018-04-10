class Transaction < ActiveRecord::Base
	validates :email, presence: true
	validates :name, presence: true
	belongs_to :showing

end