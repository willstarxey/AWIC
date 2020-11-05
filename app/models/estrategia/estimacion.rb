class Estrategia::Estimacion < ApplicationRecord
    belongs_to :colaborador, class_name: 'Colaborador'
end
