class Requerimientos::Requerimiento < ApplicationRecord
    belongs_to :colaborador, class_name: 'Colaborador'
end
