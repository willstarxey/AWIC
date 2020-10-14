class Proyecto < ApplicationRecord
    has_many :colaboradors
    has_many :users, through: :colaboradors
end
