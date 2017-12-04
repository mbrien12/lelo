class Skill < ApplicationRecord
  belongs_to :teacher, class_name: "User"
  has_many :lessons
  has_many :messages
  has_many :reviews
  geocoded_by :location
  after_validation :get_address, if: :location_changed?
  monetize :price_cents

  def self.search(params)
    skills = self.joins(:teacher).all

    skills = skills.where("lower(unaccent(skills.formatted_address)) LIKE ?",
                          "%#{params[:location].downcase}%") if params[:location].present?

    skills = skills.where("lower(unaccent(skills.name)) LIKE ?",
                         "%#{params[:skill].downcase}%") if params [:skill].present?

    return skills
  end

  def average_rating
   self.reviews.average(:rating).to_i
  end



  private

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

end
