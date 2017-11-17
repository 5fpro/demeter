module HtmlMatchers
  def response_meta_title
    response.body.scan(/<title>(.+)<\/title>/)[0][0]
  end

  def response_meta_desc
    response.body.scan(/<meta content="(.*?)" name="description" \/>/)[0][0]
  end

  def response_meta_canonical
    response.body.scan(/<link href="(.+?)" rel="canonical" \/>/)[0][0]
  end

  def response_flash_message(klass = nil)
    klass = 'danger' if klass.to_s == 'error'
    response.body.scan(/(<div class=\".*alert-#{klass}.*\">)/)[0][0]
  end
end
