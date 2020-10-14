class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #attr_accessible :nombre, :app, :apm, :edad, :sexo, :puesto, :email
  #Dependencia del usuario a un rol
  belongs_to :role, optional: true
  has_many :colaboradors
  has_many :proyectos, through: :colaboradors

  def admin?
    role.nombre == 'Administrador'
  end

  def lider?
    role.nombre = 'Lider'
  end

  def usuario?
    role.nombre == 'Usuario'
  end

end
