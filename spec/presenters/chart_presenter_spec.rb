RSpec.describe ChartPresenter do
  subject do
    ChartPresenter.new(
      unique_pageviews: [
        { date: '2018-01-13', value: 101 },
        { date: '2018-01-14', value: 202 },
        { date: '2018-01-15', value: 303 }
      ],
      pageviews: [
        { date: '2018-01-13', value: 202 },
        { date: '2018-01-14', value: 303 },
        { date: '2018-01-15', value: 404 }
      ]
    )
  end

  it 'returns start date' do
    expect(subject.from('unique_pageviews')).to eq '2018-01-13'
  end
  it 'returns end date' do
    expect(subject.to('unique_pageviews')).to eq '2018-01-15'
  end

  it 'returns the metric name in a human readable manner' do
    expect(subject.human_friendly_metric('unique_pageviews')).to eq 'Unique pageviews'
  end

  it 'returns formatted hash of chart data' do
    expect(subject.chart_data('unique_pageviews')).to eq unique_pageviews_chart_data
  end

  it 'returns multiple charts for multiple sets of data' do
    expect(subject.charts_data).to match([unique_pageviews_chart_data, pageviews_chart_data])
  end

  def unique_pageviews_chart_data
    {
      caption: "Unique pageviews from 2018-01-13 to 2018-01-15",
      chart_id: "unique_pageviews_2018-01-13-2018-01-15_chart",
      chart_label: "Unique pageviews chart",
      keys: [
        "01-13",
        "01-14",
        "01-15"
      ],
      rows: [
        {
          values: [
            101,
            202,
            303
          ]
        }
      ],
      table_id: "unique_pageviews_2018-01-13-2018-01-15_table",
      table_label: "Unique pageviews table"
    }
  end

  def pageviews_chart_data
    {
      caption: "Pageviews from 2018-01-13 to 2018-01-15",
        chart_id: "pageviews_2018-01-13-2018-01-15_chart",
        chart_label: "Pageviews chart",
        keys: [
          "01-13",
          "01-14",
          "01-15"
        ],
        rows: [
          {
            values: [
              202,
              303,
              404
            ]
          }
        ],
        table_id: "pageviews_2018-01-13-2018-01-15_table",
        table_label: "Pageviews table"
    }
  end
end
