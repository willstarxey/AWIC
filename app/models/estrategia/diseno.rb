class Estrategia::Diseno < ApplicationRecord
    belongs_to :colaborador, class_name: 'Colaborador'
end
