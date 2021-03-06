RSpec.describe ChartPresenter do
  let(:from) { '2018-01-13' }
  let(:to) { '2018-01-15' }
  subject do
    ChartPresenter.new(
      json:
        {
          unique_pageviews: [
            { date: '2018-01-13', value: 101 },
            { date: '2018-01-14', value: 202 },
            { date: '2018-01-15', value: 303 }
          ]
        },
      metric: 'unique_pageviews',
      from: from,
      to: to
    )
  end

  it 'returns start date' do
    expect(subject.from).to eq '2018-01-13'
  end
  it 'returns end date' do
    expect(subject.to).to eq '2018-01-15'
  end

  it 'returns the metric name in a human readable manner' do
    expect(subject.human_friendly_metric).to eq 'Unique pageviews'
  end

  it 'returns the correct message for no data' do
    expect(subject.no_data_message).to eq 'No Unique pageviews data for the selected time period'
  end

  it 'returns formatted hash of chart data' do
    expect(subject.chart_data).to eq unique_pageviews_chart_data
  end

  def unique_pageviews_chart_data
    {
      caption: "Unique pageviews from 2018-01-13 to 2018-01-15",
      chart_id: "unique_pageviews_chart",
      chart_label: "Unique pageviews",
      keys: [
        "01-13",
        "01-14",
        "01-15"
      ],

      rows: [
        {
          label: "Unique pageviews ",
          values: [
            101,
            202,
            303
          ]
        }
      ],
      table_id: "unique_pageviews_table",
      table_direction: "vertical"
    }
  end
end
