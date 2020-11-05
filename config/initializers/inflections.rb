# Be sure to restart your server when you modify this file.

# Add new inflection rules using the following format. Inflections
# are locale specific, and you may define rules for as many different
# locales as you wish. All of these examples are active by default:
ActiveSupport::Inflector.inflections(:en) do |inflect|
#   inflect.plural /^(ox)$/i, '\1en'
#   inflect.singular /^(ox)en/i, '\1'
#   inflect.irregular 'person', 'people'
#   inflect.uncountable %w( fish sheep )
    inflect.irregular 'meta', 'metas'
    inflect.irregular 'diseno', 'disenos'
    inflect.irregular 'criterio', 'criterios'
    inflect.irregular 'estimacion', 'estimaciones'
    inflect.irregular 'plan_calidad', 'planes_calidad'
    inflect.irregular 'requerimiento', 'requerimientos'
    inflect.irregular 'estructura', 'estructuras'
    inflect.irregular 'plan_pruebas', 'planes_pruebas'
    inflect.irregular 'estandar', 'estandares'
    inflect.irregular 'tipo_estandar', 'tipos_estandares'
    inflect.irregular 'criterio_calidad', 'criterios_calidad'
    inflect.irregular 'prueba', 'pruebas'
    inflect.irregular 'resumen', 'resumenes'
end

# These inflection rules are supported but not enabled by default:
# ActiveSupport::Inflector.inflections(:en) do |inflect|
#   inflect.acronym 'RESTful'
# end