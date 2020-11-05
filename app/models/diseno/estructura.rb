class Diseno::Estructura < ApplicationRecord
    belongs_to :colaborador, class_name: 'Colaborador'
end
