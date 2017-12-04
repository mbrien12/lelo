module ApplicationHelper
  def avatar_url
    current_user.photo_url(:thumb) || current_user.facebook_picture_url || "http://placehold.it/30x30"
  end

  def photo_url(user)
    user.photo_url(:profile) || user.facebook_picture_url || "http://placehold.it/30x30"
  end

  def teacher_photo(skill)
    skill.teacher.photo.url(:thumb) || skill.teacher.facebook_picture_url || "http://placehold.it/30x30"
  end

  def small_user_photo(user)
    user.photo.url(:thumb) || user.facebook_picture_url || "http://placehold.it/30x30"
  end

  def meetup_image(group)

    if !group['key_photo'].nil?
      "#{group['key_photo']['photo_link']}"  || 'http://cdn.embed.ly/providers/logos/meetup.png'
    else
        'http://cdn.embed.ly/providers/logos/meetup.png'
    end

  end


end

