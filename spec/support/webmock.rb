module Webmock
  def webmock_all!
    stub_request(:get, 'https://www.fisc.com.tw/TC/OPENDATA/R2_Location.csv')
      .to_return(status: 200, body: read_fixture('rs_location_test.csv'))
  end
end