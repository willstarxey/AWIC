class Role < ApplicationRecord
    #Dependencia de un rol a usuarios
    has_many :users, dependent: :restrict_with_exception
end
