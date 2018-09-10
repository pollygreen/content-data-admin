class SingleContentItemPresenter
  attr_reader :unique_pageviews, :pageviews, :unique_pageviews_series,
              :pageviews_series, :base_path, :title, :published_at, :last_updated,
              :publishing_organisation, :document_type, :number_of_internal_searches, :satisfaction_score

  def self.parse_metrics(metrics)
    new.parse_metrics(metrics.deep_symbolize_keys)
  end

  def parse_metrics(metrics)
    @unique_pageviews = metrics[:unique_pageviews]
    @pageviews = metrics[:pageviews]
    @base_path = metrics[:base_path]
    @title = metrics[:title]
    @published_at = format_date metrics[:first_published_at]
    @last_updated = format_date metrics[:public_updated_at]
    @publishing_organisation = metrics[:primary_organisation_title]
    @document_type = metrics[:document_type].tr('_', ' ').capitalize
    @number_of_internal_searches = metrics[:number_of_internal_searches],
    @satisfaction_score = metrics[:satisfaction_score]
    self
  end

  def parse_time_series(time_series)
    @unique_pageviews_series = ChartPresenter.new(json: time_series, metric: :unique_pageviews)
    @pageviews_series = ChartPresenter.new(json: time_series, metric: :pageviews)
    @number_of_internal_searches_series = ChartPresenter.new(json: time_series, metric: :number_of_internal_searches)
    self
  end

private

  def format_date(date_str)
    Date.parse(date_str).strftime('%-d %B %Y')
  end
end
