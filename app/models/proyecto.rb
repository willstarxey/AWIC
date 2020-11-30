class Proyecto < ApplicationRecord
    has_many :colaboradors
    has_many :users, through: :colaboradors
    has_many :diseno_tipos_estandares, class_name: 'Diseno::TipoEstandar'
    has_many :postmortem_resumenes, class_name: 'Postmortem::Resumen'
end
