class Api::V1::RessourcesController < Api::ApplicationController

  def index
    render  status: 200,
            json: {
              status: :success,
              data: {
                users: User.all,
              }
            }

  end


end
