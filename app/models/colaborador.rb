class Colaborador < ApplicationRecord
    belongs_to :proyecto, inverse_of: :colaboradors
    belongs_to :user, inverse_of: :colaboradors
    has_many :lanzamiento_metas, class_name: 'Lanzamiento::Meta'
end
