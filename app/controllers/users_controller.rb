
class UsersController < ApplicationController

def index
@users=User.all
end

def show
@user = User.find(params[:id])
end

def new
@user = User.new
end

def edit
@user=User.find(params[:id])
end

def create
@user = User.new(user_params)
@user.cart=Cart.create
@user.cart.get_items(nil)

if @user.save
   #flash[:success] = "Welcome to the Sample App!"
   log_in @user
   redirect_to products_path
else
   render 'new'
end
end

def update
  @user = User.find(params[:id])
 
  if @user.update(user_params)
    redirect_to @user
  else
    render 'edit'
  end
end

def destroy
@user=User.find(params[:id])
@user.destroy

redirect_to users_path
end

private
    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
end