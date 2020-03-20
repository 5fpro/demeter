module ApplicationHelper
  def icon(name, options = {})
    options = options.symbolize_keys
    options[:class] ||= 'icon'
    content_tag :svg, options do
      tag :use, 'xlink:href' => "#icon-#{name}"
    end
  end

  def cdn_image_srcset(basename, widths, extname = '.jpg')
    origin = "https://#{cdn_host}/statics"
    widths.map do |width|
      "#{origin}/#{basename}-#{width}#{extname} #{width}w"
    end.join(', ')
  end

  def cdn_picture_tag(file_name, widths, options = {})
    options = options.symbolize_keys
    basename = File.basename(file_name, '.*')
    extname = File.extname(file_name)
    render partial: 'components/picture', locals: {
      type: extname.split('.').last,
      src: "https://#{cdn_host}/statics/#{basename}-#{widths[0]}#{extname}",
      srcset: cdn_image_srcset(basename, widths, extname),
      webp_srcset: cdn_image_srcset(basename, widths, '.webp'),
      options: options
    }
  end

  def cdn_host
    ENV['CDN_HOST'] || ENV['ASSET_HOST']
  end
end
