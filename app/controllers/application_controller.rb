class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  USERS = [
    {
      id: 1,
      username: 'mthbo',
      password: 'secret'
    },
    {
      id: 2,
      username: 'juju',
      password: 'secret'
    }
  ]

  private

  def current_user
    @_current_user ||= session[:current_user_id]
  end

end
