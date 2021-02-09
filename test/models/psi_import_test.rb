require 'test_helper'

class PsiImportTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
	test "Importing CSV" do
		Rails.application.load_seed
		user = User.first
		
		csv = File.open('test-for-import-logbook.csv')
		PsiImport.import(csv)
		assert true
		
		PsiImport.convert(user)
		assert true
		
		
	end
end
