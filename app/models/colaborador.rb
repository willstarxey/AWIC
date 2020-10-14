class Colaborador < ApplicationRecord
    belongs_to :proyecto
    belongs_to :user
end
