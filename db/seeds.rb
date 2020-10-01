# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#Establecimiento de roles básicos y estáticos para la aplicación
Role.create({ nombre: 'Administrador', descripcion: 'Administrador de la aplicación con respecto a usuarios y proyectos' })
Role.create({ nombre: 'Lider', descripcion: 'Usuario que puede realizar ediciones a proyectos y repartir tareas' })
Role.create({ nombre: 'Usuario', descripcion: 'Usuario que realiza tareas de proyectos' })