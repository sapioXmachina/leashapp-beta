class ApplicationMailer < ActionMailer::Base
  default :from => ENV["APPLICATION_MAILER"]

  layout "mailer"

  # require "uri"
  # require "net/http"
  # require "json"

  # url = URI.parse(ENV['TRUSTIFI_URL'] "/api/i/v1/email")
  # https = Net::HTTP.new(url.host, url.port)
  # https.use_ssl = true

  # request = Net::HTTP::Post.new(url)
  # request["x-trustifi-key"] = ENV['TRUSTIFI_KEY']
  # request["x-trustifi-secret"] = ENV['TRUSTIFI_SECRET']
  # request["content-type"] = "application/json"
  # request.body = "{\"recipients\": [{\"email\": \"test@trustificorp.org\"}],\"title\":\"Title\",\"html\":\"Body\"}"

  # response = https.request(request)
  # puts response.read_body
end
