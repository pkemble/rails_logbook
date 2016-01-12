class TimeFormatValidator < ActiveModel::EachValidator
  def validate_each(rec, attr, val)
    barr = val.scan(/.{2}/)
    unless val.length == 4 && barr[0].to_i.between?(00,23) && barr[1].to_i.between?(00,59)
      str_msg = 'Time doesn\'t seem to fit convention: HHMM' # + barr[0] + ' - ' + barr[1]
      rec.errors.add(attr, str_msg)
    end
  end
end