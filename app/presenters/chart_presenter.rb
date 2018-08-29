class ChartPresenter
  attr_reader :json

  def initialize(json)
    @json = json.to_h.with_indifferent_access
  end

  def from(metric_name)
    json[metric_name].first[:date]
  end

  def to(metric_name)
    json[metric_name].last[:date]
  end

  def human_friendly_metric(metric_name)
    (metric_name).tr('_', ' ').capitalize
  end

  def charts_data
    json.keys.map do |metric_name|
      chart_data(metric_name)
    end
  end



  def chart_data(metric_name)
    {
      caption: "#{human_friendly_metric(metric_name)} from #{from(metric_name).to_date} to #{to(metric_name).to_date}",
      chart_label: "#{human_friendly_metric(metric_name)} chart",
      table_label: "#{human_friendly_metric(metric_name)} table",
      chart_id: "#{metric_name}_#{from(metric_name)}-#{to(metric_name)}_chart",
      table_id: "#{metric_name}_#{from(metric_name)}-#{to(metric_name)}_table",
      keys: keys(metric_name),
      rows: [
        {
          values: values(metric_name)
        }
      ]
    }
  end

  def keys(metric_name)
    dates = json[metric_name].map { |hash| hash['date'] }
    dates.map { |date| date.last(5) }
  end

  def values(metric_name)
    json[metric_name].map { |hash| hash['value'] }
  end
end
