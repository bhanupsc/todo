class Task < ApplicationRecord
	belongs_to :catagory
	has_one :user, through: :catagory

	validates_presence_of :name
	validate :check_due_date



	def check_due_date
		if due_date.present? && due_date < Date.today
				errors.add(:due_date, ": Past date not allowed")
		end
	end


end
