class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook]
  has_many :skills, foreign_key: :teacher_id
  has_many :lessons, foreign_key: :student_id
  has_many :messages, foreign_key: :sender_id
  has_many :messages, foreign_key: :receiver_id
  mount_uploader :photo, PhotoUploader
  geocoded_by :location
  after_validation :get_address, if: :location_changed?

  def self.find_for_facebook_oauth(auth)
    user_params = auth.slice(:provider, :uid)
    user_params.merge! auth.info.slice(:email, :first_name, :last_name)
    user_params[:facebook_picture_url] = auth.info.image
    user_params[:token] = auth.credentials.token
    user_params[:token_expiry] = Time.at(auth.credentials.expires_at)
    user_params = user_params.to_h

    user = User.find_by(provider: auth.provider, uid: auth.uid)
    user ||= User.find_by(email: auth.info.email) # User did a regular sign up in the past.
    if user
      user.update(user_params)
    else
      user = User.new(user_params)
      user.password = Devise.friendly_token[0,20]  # Fake password for validation
      user.save
    end

    return user
  end


    def get_address
    google = "https://maps.googleapis.com/maps/api/geocode/json?address="
    key = ENV['GOOGLE_API_SERVER_KEY']
    url = "#{google}#{self.location}&key=#{key}"

    if !self.location.blank?
      address_hash = JSON.parse(open(url).read)
      if address_hash['status'] == 'OK'
        address_hash = address_hash["results"][0]
        self.formatted_address = address_hash["formatted_address"]
        self.latitude = address_hash["geometry"]["location"]["lat"]
        self.longitude = address_hash["geometry"]["location"]["lng"]
      end
    end
  end

  def name
    "#{self.first_name} #{self.last_name}"
  end

end
