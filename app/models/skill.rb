class Skill < ApplicationRecord
  belongs_to :teacher, class_name: "User"
  has_many :lessons
  has_many :messages

  def self.search(params)
    skills = self.joins(:teacher).all

    skills = skills.where("lower(unaccent(users.formatted_address)) LIKE ?",
                          "%#{params[:location].downcase}%") if params[:location].present?

    skills = skills.where("lower(unaccent(skills.name)) LIKE ?",
                         "%#{params[:skill].downcase}%") if params [:skill].present?

    return skills
  end
end
