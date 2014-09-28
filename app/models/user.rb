class User < ActiveRecord::Base
  self.primary_key = :id

  default_scope do
    order :created_at
  end

  extend Canonical::UUID

  has_many :tasks
  has_many :complete_tasks,   -> { complete },   class_name: "Task"
  has_many :incomplete_tasks, -> { incomplete }, class_name: "Task"

  def preferences
    {
      max_hours_per_day:    max_hours_per_day,
      min_hours_per_task:   min_hours_per_task,
      max_hours_per_task:   max_hours_per_task,
      days_to_show_at_once: days_to_show_at_once
    }
  end

  before_save :round_preferences!

  def round_preferences!
    roundable_preferences.each do |preference|
      unrounded = self.send preference
      self.send :"#{preference}=", unrounded.round_to_quarter
    end
  end

  private def roundable_preferences
    %i[
      min_hours_per_task
      days_to_show_at_once
      max_hours_per_task
    ]
  end

####
# DEVISE AUTHENTICATION STUFF
##

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, length: { minimum: 6 }

  class << self

    def from_omniauth(auth)
      where(auth.slice(:provider, :uid)).first_or_create do |user|
        user.provider = auth.provider
        user.uid = auth.uid
        user.username = auth.info.nickname
      end
    end

    def new_with_session(params, session)
      if session["devise.user_attributes"]
        new(session["devise.user_attributes"], without_protection: true) do |user|
          user.attributes = params
          user.valid?
        end
      else
        super
      end
    end

  end

  def password_required?
    super && provider.blank?
  end

  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end

end
