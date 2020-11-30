class Diseno::TipoEstandar < ApplicationRecord
    has_many :estandares, class_name: 'Diseno::Estandar'
    belongs_to :proyecto
end
