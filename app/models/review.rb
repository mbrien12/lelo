class Review < ApplicationRecord
   belongs_to :skill
   belongs_to :student, class_name: "User"

end
