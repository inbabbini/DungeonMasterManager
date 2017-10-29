class User < ApplicationRecord
  #Model callbacks
  before_save :encrypt_password
  after_save :clear_password

  # Model Associations
  has_many :mastered_games, class_name: 'Game', inverse_of: :dungeon_master, foreign_key: 'dungeon_master_id'
  has_and_belongs_to_many :played_games, class_name: 'Game'
  has_many :characters

  #Atribute accessors
  attr_accessor :password

  # Model Validations
  EMAIL_REGEX = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :name,
    presence: true,
    length: { in: 1..255 }

  validates :email,
    presence: true,
    uniqueness: true,
    format: EMAIL_REGEX

  validates :password,
    confirmation: true

  validates_length_of :password, :in => 6..20, :on => :create

  # Class Methods
  def self.find_or_create(auth)
		where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
			user.provider = auth.provider
			user.uid = auth.uid
			user.name = auth.info.first_name + " " + auth.info.last_name
			user.email = auth.info.email
			user.picture = auth.info.image
			user.save!
    end
  end

  def self.find_and_authenticate(auth_params)
    if  EMAIL_REGEX.match(auth_params[:email])
      user = User.find_by_email(auth_params[:email])
    end
    if user && user.match_password(auth_params[:password])
      return user
    else
      return nil
    end
  end

  def match_password(login_password)
    encrypted_password == BCrypt::Engine.hash_secret(login_password, salt)
  end

  # Instance Methods
  def encrypt_password
    if password.present?
      self.salt = BCrypt::Engine.generate_salt
      self.encrypted_password= BCrypt::Engine.hash_secret(password, salt)
    end
  end
  def clear_password
    self.password = nil
  end

  def is_owner?(resource)
    resource.is_owned_by? self
  end

  def is_dm_or_player?(game)
    game.is_related_to? self
  end

end
