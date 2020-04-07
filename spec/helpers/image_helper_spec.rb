require 'rails_helper'

RSpec.describe ImageHelper, type: :helper do
  it '#cdn_image_srcset' do
    basename = 'statics/123'
    expected = "https://#{Setting.cdn_host}/#{basename}-100.jpg 100w, https://#{Setting.cdn_host}/#{basename}-300.jpg 300w"
    expect(cdn_image_srcset(basename, [100, 300], '.jpg')).to eq(expected)
    expect(cdn_image_srcset('/' + basename, [100, 300], '.jpg')).to eq(expected)
  end

  it '#cdn_image_tag' do
    basename = 'statics/123'
    expected_match = "https://#{Setting.cdn_host}/#{basename}-100.jpg"
    expect(cdn_image_tag("#{basename}.jpg", [100, 300])).to include(expected_match)
  end
end
