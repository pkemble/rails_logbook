puts "This script deletes the Flight and Entry tables.\n\n"
#confirm = HighLine.agree("Delete Flight and Entry tables? [Y/N] ") { |yn| yn.limit = 1, yn.validate = /[yn]/i }
#exit unless confirm.downcase == 'y'

if Flight.delete_all && Entry.delete_all
	puts "Finished."
end

