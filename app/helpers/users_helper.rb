module UsersHelper

  #img che segue nome di pag in pag
  def gravatar_for(user)
    # codifica hash md5 email user
    gravatar_id = Digest::MD5::hexdigest(user.email)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end
end
