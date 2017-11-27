module ApplicationHelper
  def avatar_url
    current_user.photo_url(:thumb) || current_user.facebook_picture_url || "http://placehold.it/30x30"
  end

  def photo_url
    current_user.photo_url(:profile) || current_user.facebook_picture_url || "http://placehold.it/30x30"
  end
end

