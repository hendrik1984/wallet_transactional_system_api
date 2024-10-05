class ApplicationController < ActionController::API
  def authorization
    begin
      SessionSignature.verify(request.headers[:Authorization])
    rescue => e
      render json: JsonCustomResponse.reformat("", 'Invalid Token', 422), status: :unprocessable_entity
    end
  end
end
