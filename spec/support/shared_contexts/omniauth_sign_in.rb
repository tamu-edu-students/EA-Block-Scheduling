# /spec/support/shared_contexts/omniauth_sign_in.rb

RSpec.shared_context 'omniauth_sign_in' do
  let(:admin_user) { create(:admin_user) }

  before do
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:google_oauth2] = {
      'uid' => '1234567890',
      'info' => {
        'email' => admin_user.email,
        'name' => "#{admin_user.first_name} #{admin_user.last_name}"
      },
      'credentials' => {
        'token' => 'fake_token',
        'refresh_token' => 'fake_refresh_token',
        'expires_at' => Time.now.to_i + 3600
      }
    }

    allow(controller).to receive(:current_user).and_return(admin_user)
  end
end
