require 'net/http'
require 'uri'

class Github

  ROOT_URL = 'https://api.github.com'

  def self.get_contributors repos_url
    return nil if repos_url.exclude?('https://github.com')
    logger = Logger.new "#{Rails.root}/log/github.log"
    repos_name = repos_url.delete(' ').gsub('https://github.com/', '')
    url = ROOT_URL + "/repos/#{repos_name}" + '/stats/contributors'
    uri = URI.parse url
    logger.info "#{Time.zone.now} Request: #{repos_url}"

    response = Net::HTTP.get_response(uri)
    resp_body = response.body
    if resp_body
      all_contributors = JSON.parse(resp_body)
      last_contributors = all_contributors.last(3)
      logger.info "#{Time.zone.now} Response: #{last_contributors}"
      active_users_name = last_contributors.map {|user| user['author']['login']}
    else
      return nil
    end

    { users: active_users_name, repos_name: repos_name }
  rescue
    logger.info "#{Time.zone.now} #{repos_url} error"
    nil
  end

end
