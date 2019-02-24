class Task < ApplicationRecord
	belongs_to :catagory
	has_one :user, through: :catagory

	validates_presence_of :name
end
