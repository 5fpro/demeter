class SlackService
  WEBHOOK = "https://hooks.slack.com/services/xxxxx/xxxx"
  DEFAULT_ICON_URL = "https://slack-assets2.s3-us-west-2.amazonaws.com/5504/img/emoji/1f680.png"

  class << self
    def notify(message, channel: "#general", name: "slackbot", icon_url: DEFAULT_ICON_URL, webhook: nil)
      notify = Slack::Notifier.new(webhook || WEBHOOK, channel: channel, username: name)
      message = "[#{Rails.env}] #{message}" unless Rails.env.production?
      notify.ping(message, icon_url: icon_url)
    end

    def notify_async(message, channel: "#general", name: "slackbot", icon_url: DEFAULT_ICON_URL, webhook: nil)
      self.delay.notify(message, channel: channel, name: name, icon_url: icon_url, webhook: webhook)
    end
  end

end
