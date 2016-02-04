class ImportExport < ActiveRecord::Base
  def psi_output
    @t = Time.now.prev_month.beginning_of_month
    @e = Time.now.prev_month.end_of_month
    @entries = Entry.where(date: @t..@e).order(:date)
            # <!-- using Expense report 1/2016 -->
        # <td><%= e.date.strftime("%m/%d/%Y") %></td>
        # <td><%= e.tail %></td>
        # <td><%= e.arpt_string %></td>
        # <td></td><!-- hidden column -->
        # <td></td><!-- catering -->
        # <td></td><!-- travel exp. -->
        # <td><%= e.tips %></td>
        # <td></td><!-- other exp. -->
        # <td><%= e.remarks %></td>
        # <td><%= e.crew_meal %></td>
        # <td><%= e.per_diem_hours %></td>
    @entries.each do |e|
      psi_output = e.datestrftime("%m/%d/%Y")
      psi_output += e.tail
    end
  end
end
