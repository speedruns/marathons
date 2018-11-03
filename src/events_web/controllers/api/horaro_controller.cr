class API::HoraroController < APIController
  def show
    schedule_id = request.path_params["schedule_id"]
    response = HTTP::Client.get("https://horaro.org/-/api/v1/schedules/#{schedule_id}")

    render_json response.body
  end
end
