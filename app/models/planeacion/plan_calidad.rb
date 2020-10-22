class Planeacion::PlanCalidad < ApplicationRecord
    belongs_to :colaborador, class_name: 'Colaborador'
end
