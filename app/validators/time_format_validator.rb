class TimeFormatValidator < ActiveModel::EachValidator
  def validate_each(rec, attr, val)
    if val.nil? || val.length == 0
      Rails.logger.debug "Validation skipped : #{rec} \n-- #{attr} = nil value, returning"
      return true
    end
    Rails.logger.debug "Starting validator for: \n #{rec} \n #{attr} \n #{val}"
    barr = val.scan(/.{2}/)
    unless val.length == 4 && barr[0].to_i.between?(00,23) && barr[1].to_i.between?(00,59)
      str_msg = 'Time doesn\'t seem to fit convention: HHMM' # + barr[0] + ' - ' + barr[1]
      rec.errors.add(attr, str_msg)
      Rails.logger.debug "Validation FAILED for : \n #{rec} \n #{attr} \n #{val}"
    end
  end
end