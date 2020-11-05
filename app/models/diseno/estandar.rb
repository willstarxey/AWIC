class Diseno::Estandar < ApplicationRecord
    belongs_to :colaborador, class_name: 'Colaborador'
end
