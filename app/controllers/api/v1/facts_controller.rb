class Api::V1::FactsController < ApplicationController
	before_action :authenticate_request! 
	
	def index
		@facts = Fact.all
		render json: @facts	
	end

	def show
		@fact = Fact.find(params[:id])
		render json: @fact
	end

	def create
		@fact = Fact.new(fact_params)
		if @fact.save
			render json: @fact
		else
			render error: { error: 'Unable to create a User' }, status: 400
		end
	end

	def update
		@fact = User.find(params[:id])
		if @fact
			@fact.update(fact_params)
			render json: { message: 'User successfully updated'}, status: 200
		else
			render json: { error: 'Unable to update User' }, status: 400
		end
	end

	def destroy
		@user = User.find(params[:id])
		if @fact
			@fact.destroy
			render json: { message: 'User successfully updated'}, status: 200
		else
			render json: { error: 'Unable to update User' }, status: 400
		end
	end

	private
		def fact_params
			params.require(:fact).permit(:fact, :likes, :user_id)
		end
end
