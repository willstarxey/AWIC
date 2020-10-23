class Estrategia::Criterio < ApplicationRecord
    belongs_to :colaborador, class_name: 'Colaborador'
end
