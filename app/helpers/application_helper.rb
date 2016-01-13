module ApplicationHelper
  def on_trip_sheet_page
    current_page?('/static_pages/tripsheet.html')
  end
end
