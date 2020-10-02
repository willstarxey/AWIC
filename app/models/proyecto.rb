class Proyecto < ApplicationRecord
    belongs_to :user, optional: true
end
