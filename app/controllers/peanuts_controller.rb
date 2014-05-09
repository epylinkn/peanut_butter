class PeanutsController < ApplicationController
  def index
    if q = params[:query]
      @counts = Proposition.query(q)
    end
  end

  def query
  end
end
