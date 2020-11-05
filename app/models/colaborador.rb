class Colaborador < ApplicationRecord
    belongs_to :proyecto, inverse_of: :colaboradors
    belongs_to :user, inverse_of: :colaboradors
    has_many :diseno_estandares, class_name: 'Diseno::Estandar'
    has_many :diseno_estructuras, class_name: 'Diseno::Estructura'
    has_many :diseno_planes_pruebas, class_name: 'Diseno::PlanPruebas'
    has_many :lanzamiento_metas, class_name: 'Lanzamiento::Meta'
    has_many :estrategia_criterios, class_name: 'Estrategia::Criterio'
    has_many :estrategia_disenos, class_name: 'Estrategia::Diseno'
    has_many :estrategia_estimaciones, class_name: 'Estrategia::Estimacion'
    has_many :implementacion_criterios_calidad, class_name: 'Implementacion::CriterioCalidad'
    has_many :planeacion_planes_calidad, class_name: 'Planeacion::PlanCalidad'
    has_many :requerimientos_requerimientos, class_name: 'Requerimientos::Requerimiento'
    has_many :postmortem_resumenes, class_name: 'Postmortem::Resumen'
    has_many :pruebas_pruebas, class_name: 'Pruebas::Prueba'
end
