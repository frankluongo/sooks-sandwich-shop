class ContentController < ApplicationController
  def index
    puts "======================"
  end

  def about
    puts "================="
    @test = 'hi'
  end
end
