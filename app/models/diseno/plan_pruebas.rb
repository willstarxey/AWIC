class Diseno::PlanPruebas < ApplicationRecord
    belongs_to :colaborador, class_name: 'Colaborador'
end
