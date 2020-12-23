class Diseno::Estandar < ApplicationRecord
    belongs_to :colaborador, class_name: 'Colaborador'
    belongs_to :tipo_estandar, class_name: 'Diseno::TipoEstandar'
end
