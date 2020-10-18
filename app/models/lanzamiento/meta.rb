class Lanzamiento::Meta < ApplicationRecord
    belongs_to :colaborador, class_name: 'Colaborador'
end