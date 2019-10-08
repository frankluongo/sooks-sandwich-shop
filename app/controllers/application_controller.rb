class ApplicationController < ActionController::Base
  private

  def create_guest_user
    u = User.new(
      :name => "guest",
      :email => "guest_#{Time.now.to_i}#{rand(100)}@example.com",
      :username => "guest_#{Time.now.to_i}#{rand(100)}"
    )
    u.save!(:validate => false)
    session[:guest_user_id] = u.id
    u
  end
end
