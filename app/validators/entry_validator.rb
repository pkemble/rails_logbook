class NotDuplicateValidator < ActiveModel::EachValidator
#  def validate
#    byebug
#    @duplicates = Entry.where(date: self.date).where(tail: self.tail).select('*')
#    if @duplicates.count > 0
#      @map = @duplicates.map {|row| row[:id]}
#      @duplicate_list = ''
#      @map.each do |d|
#        @duplicate_list << "\n" + d.to_s
#      end
#      errors.add(:base, "Duplicate found: " + @duplicate_list)
#      return false
#    end
#    return true
#  end
end