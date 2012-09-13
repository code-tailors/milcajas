module UserHelper

  def access(user)
    visit home_path
    VCR.use_cassette('allow_dropbox') do
      click_link 'access'
    end
  end

  def current_user
    User.where(uid: request.env["omniauth.auth"].uid.to_s).first rescue nil
  end

  def create_omniauth(uid=Random.number(999999))
    firstname = Random.firstname
    OmniAuth.config.mock_auth[:dropbox] =    OmniAuth::AuthHash.new ({
                              :provider => "dropbox",
                              :uid      => uid,
                              :credentials => {
                                :secret   => Random.alphanumeric,
                                :token    => Random.alphanumeric
                              },
                              :info     => {
                                :email   => "#{firstname}@#{["hotmail", "gmail","ciudad"].sample}.com",
                                :name    => firstname
                              }
    })
  end

  def real_omniauth
    OmniAuth.config.mock_auth[:dropbox] =    OmniAuth::AuthHash.new ({
                              :provider => "dropbox",
                              :uid      => 3810241,
                              :credentials => {
                                :secret   => "u7mnci2j45y7dvd",
                                :token    => "6gx2428ks90zvti"
                              },
                              :info     => {
                                :email   => "superman@justiceleague.com",
                                :name    => "Superman"
                              }
    })
  end

end
