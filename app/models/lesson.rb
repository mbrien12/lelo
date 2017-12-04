class Lesson < ApplicationRecord
  belongs_to :skill
  belongs_to :student, class_name: "User"
  validates :date, :name, presence: true
  monetize :price_cents

  def teacher
    self.skill.teacher
  end

  def complete!
    self.completed = true
    self.save
  end

  def completed?
    self.completed
  end

  def cancel!
    self.completed = false
    self.save
  end
end
