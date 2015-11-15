class FlightValidator < ActiveModel::EachValidator
  def validate_each(rec, attr, val)
    barr = val.to_s.scan(/.{2}/)
    p val.to_s
    p val.to_s.length
    p barr[0]
    p barr[1]
    unless barr[0].to_i.between?(00,23) && barr[1].to_i.between?(00,59)
      
      errors.add(:base, 'WTF TIEM')
      
    end
    p "yup"
  end
end