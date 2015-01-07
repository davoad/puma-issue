class HelloController < ApplicationController
  def hello
    respond_to do |format|
      format.json do
        sleep 20
        render json: 'Hello'
      end
    end
  end
end
