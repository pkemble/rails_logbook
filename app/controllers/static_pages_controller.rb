class StaticPagesController < ApplicationController
  def tripsheet
    @flights = (1..6).to_a
    @flight = Flight.new #for the error control on the flights partial form that is being rendered
  end
end
