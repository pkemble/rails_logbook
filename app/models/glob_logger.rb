class GlobLogger
  def self.debug(message=nil)
    @glob_log ||= Logger.new("#{Rails.root}/log/glob.log")
    @glob_log.debug(message) unless message.nil?
  end
end