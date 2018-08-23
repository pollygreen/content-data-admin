class MetricsController < ApplicationController
  def show
    @base_path = params[:base_path]
    service = MetricsService.new
    @metrics = service.fetch(
      base_path: params[:base_path],
      from: params[:from],
      to: params[:to],
      metric: params[:metric]
    ).to_hash
  end
end