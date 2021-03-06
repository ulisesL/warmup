class UsersController < ApplicationController
  
  #login definition starts here
  def login
  	@user = User.new(username: params[:user], password: params[:password], counter: 1)

    if ((@user.password.length() < 1) or (@user.password.length() > 128)) 
      respond_to do |format| 
        format.json {render json: {errCode: -4}}
      end
    else 
      if ((@user.username.length() < 1) or (@user.username.length() > 128))
        respond_to do |format| 
          format.json {render json: {errCode: -3}}
        end
    
      else
      	if User.exists?(username: params[:user], password: params[:password])
      		
      		temp = User.find_by_username(params[:user])
      		temp.counter += 1
      		temp.save 


      		respond_to do |format| 
      			format.json {render json: {errCode: 1, count: temp.counter}} 
      		end
      	else
      		respond_to do |format| 
      			format.json {render json: {errCode: -1}} 
      		end
      	end
      end
    end
  end
  #login definition ends here

  #add definition starts here
  def add
  	@user = User.new(username: params[:user], password: params[:password], counter: 1)


    if ((@user.password.length() < 1) or (@user.password.length() > 128)) 
      respond_to do |format| 
        format.json {render json: {errCode: -4}}
      end
    else 
      if ((@user.username.length() < 1) or (@user.username.length() > 128))
        respond_to do |format| 
          format.json {render json: {errCode: -3}}
        end
    
      else
      	if User.exists?(username: params[:user]) 

      		respond_to do |format| 
      			format.json {render json: {errCode: -2}} 
      		end

      	else
      		
      		@user.save
      		respond_to do |format| 
      		format.json {render json: {errCode: 1, count: 1}} 
      		end
      	end
      end
    end
  end
  #add definition ends here
  
end
