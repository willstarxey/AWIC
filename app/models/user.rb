class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #attr_accessible :nombre, :app, :apm, :edad, :sexo, :puesto, :email

  belongs_to :role, optional: true

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
