class User < ActiveRecord::Base
  after_create :add_citizen_role

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  has_and_belongs_to_many :roles

  def role?(role)
    return !!self.roles.find_by_name(role.to_s)
  end

  # ADMIN

  def make_admin
    self.roles << Role.admin
  end

  def revoke_admin
    self.roles.delete(Role.admin)
  end

  def admin?
    role?(:admin)
  end

  # CITIZEN

  def make_citizen
    self.roles << Role.citizen
  end

  def revoke_citizen
    self.roles.delete(Role.citizen)
  end

  def citizen?
    role?(:citizen)
  end

  # ALDERMAN

  def make_alderman
    revoke_citizen
    self.roles << Role.alderman
  end

  def revoke_alderman
    self.roles.delete(Role.alderman)
  end

  def alderman?
    role?(:alderman)
  end

  # ASSEMBLY PRESIDENT

  def make_assembly_president
    revoke_alderman
    self.roles << Role.assembly_president
  end

  def revoke_assembly_president
    self.roles.delete(Role.assembly_president)
  end

  def assembly_president?
    role?(:assembly_president)
  end

  private

  def add_citizen_role
    make_admin
  end
end
