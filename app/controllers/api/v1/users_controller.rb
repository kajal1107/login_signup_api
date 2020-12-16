class Api::V1::UsersController < ApplicationController
	before_action :authenticate_request!, except: [:create, :login] # Exclude this route from authentication
  before_action :set_user, only: [:show, :update, :destroy]

  def login
  	byebug
    user = User.find_by(username: user_params[:username])

    if user&.authenticate(user_params[:password])
      auth_token = JsonWebToken.encode(user_id: user.id)
      render json: { auth_token: auth_token }, status: :ok
    else
      render json: { error: 'Invalid username/password' }, status: :unauthorized
    end
  end


  # GET /users
  def index
    @users = User.all

    render json: @users
  end

  # GET /users/1
  def show
    render json: @user
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:username, :password, :password_confirmation)
    end


	# def index
	# 	@users = User.all
	# 	render json: @users	
	# end

	# def show
	# 	@user = User.find(params[:id])
	# 	render json: @user
	# end

	# def create
	# 	@user = User.new(user_params)
	# 	if @user.save
	# 		render json: @user
	# 	else
	# 		render error: { error: 'Unable to create a User' }, status: 400
	# 	end
	# end

	# def update
	# 	@user = User.find(params[:id])
	# 	if @user
	# 		@user.update(user_params)
	# 		render json: { message: 'User successfully updated'}, status: 200
	# 	else
	# 		render json: { error: 'Unable to update User' }, status: 400
	# 	end
	# end

	# def destroy
	# 	@user = User.find(params[:id])
	# 	if @user
	# 		@user.destroy
	# 		render json: { message: 'User successfully updated'}, status: 200
	# 	else
	# 		render json: { error: 'Unable to update User' }, status: 400
	# 	end
	# end

	# private
	# 	def user_params
	# 		params.require(:user).permit(:username, :password)
	# 	end

end
