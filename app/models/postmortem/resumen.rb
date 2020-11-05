class Postmortem::Resumen < ApplicationRecord
    belongs_to :colaborador, class_name: 'Colaborador'
end
