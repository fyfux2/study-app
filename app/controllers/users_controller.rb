class UsersController < ApplicationController

  def index
    @users = User.all.order(:last_name)


  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to action: :index, notice: 'Lietotājs ir izviedots'
    else
      render :new
    end
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to action: :index, notice: 'Lietotājs veiksmīgi labots'
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    redirect_to action: :index
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :teacher)
  end

end
