module ImageHelper
  def icon_svg(name, options = {})
    options = options.symbolize_keys
    options[:class] ||= 'icon'
    content_tag :svg, options do
      tag :use, 'xlink:href' => "#icon-#{name}"
    end
  end

  def cdn_image_srcset(basename_with_path, widths, extname = '.jpg')
    basename_with_path = "/#{basename_with_path}" if basename_with_path[0] != '/'
    origin = "https://#{cdn_host}"
    widths.map do |width|
      "#{origin}#{basename_with_path}-#{width}#{extname} #{width}w"
    end.join(', ')
  end

  def cdn_image_tag(file_path, widths, options = {})
    options = options.symbolize_keys
    dirname = File.dirname(file_path)
    basename = File.basename(file_path, '.*')
    extname = File.extname(file_path)
    render partial: '_components/picture', locals: {
      type: extname.split('.').last,
      src: "https://#{cdn_host}#{dirname}/#{basename}-#{widths[0]}#{extname}",
      srcset: cdn_image_srcset("#{dirname}/#{basename}", widths, extname),
      webp_srcset: cdn_image_srcset(basename, widths, '.webp'),
      options: options
    }
  end

  def cdn_host
    Setting.cdn_host
  end
end
