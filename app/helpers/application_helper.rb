module ApplicationHelper
  def avatar_url
    current_user.photo_url(:thumb) || current_user.facebook_picture_url.present? {"#{current_user.facebook_picture_url}&height=50&width=50"} || "http://placehold.it/30x30"
  end

  def photo_url(user)
    user.photo_url(:profile) || user.facebook_picture_url.present? {"#{user.facebook_picture_url}&height=200&width=200"} || "http://placehold.it/30x30"
  end

  def teacher_photo(skill)
    skill.teacher.photo.url(:thumb) ||
    skill.teacher.facebook_picture_url.present? {"#{skill.teacher.facebook_picture_url}&height=50&width=50"} ||
    "http://placehold.it/30x30"
  end

  def small_user_photo(user)
    user.photo.url(:thumb) || user.facebook_picture_url.present? {"#{user.facebook_picture_url}&height=50&width=50"} || "http://placehold.it/30x30"
  end

  def meetup_image(group)

    if !group['key_photo'].nil?
      "#{group['key_photo']['photo_link']}"  || 'http://cdn.embed.ly/providers/logos/meetup.png'
    else
        'http://cdn.embed.ly/providers/logos/meetup.png'
    end
  end

  def title(text)
    content_for :title, text
  end

    def meta_title
    content_for?(:meta_title) ? content_for(:meta_title) : DEFAULT_META["meta_title"]
  end

  def meta_description
    content_for?(:meta_description) ? content_for(:meta_description) : DEFAULT_META["meta_description"]
  end

  def meta_image
    meta_image = (content_for?(:meta_image) ? content_for(:meta_image) : DEFAULT_META["meta_image"])
    # little twist to make it work equally with an asset or a url
    meta_image.starts_with?("http") ? meta_image : image_url(meta_image)
  end


end

