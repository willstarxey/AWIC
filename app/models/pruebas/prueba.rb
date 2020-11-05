class Pruebas::Prueba < ApplicationRecord
    belongs_to :colaborador, class_name: 'Colaborador'
end
