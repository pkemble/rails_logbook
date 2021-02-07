class TotalsController < ApplicationController
	def index
		@totals = TotalsHelper::Totals.new
	end
end