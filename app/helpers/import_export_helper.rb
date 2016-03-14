module ImportExportHelper
  def past_months
    @dates = Entry.select(:date)
    @dates.each do |d|
      
    end
  end
end
