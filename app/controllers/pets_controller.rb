class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do 
    @owners = Owner.all 
    erb :'/pets/new'
  end

  post '/pets' do 
    @pet = Pet.new(params[:pet])
    if !params["owner"]["name"].empty?
      @pet.owner = Owner.create(name: params["owner"]["name"])
    else 
      @pet.owner = Owner.find_by_id(params[:pet][:owner_id])
    end 
    @pet.save
    redirect to "/pets/#{@pet.id}"
  end
  
  get '/pets/:id/edit' do 
    @pet = Pet.find_by_id(params[:id])
    @owners = Owner.all 
    erb :'pets/edit'
  end

  get '/pets/:id' do 
    @pet = Pet.find_by_id(params[:id])
    erb :'/pets/show'
  end

  patch '/pets/:id' do 
    # if !params[:owner].keys.include?("pet_ids")
    #   params[:owner]["pet_ids"] = []
    # end 
    
    @pet = Pet.find(params[:pet][:owner_id])
    @pet.update(params[:pet])
    if !params["owner"]["name"].empty?
      @pet.owner = Owner.create(name: params["owner"]["name"])
    else 
      @pet.owner = Owner.find(name: params["owner"]["name"])
    end 
    @pet.save
    redirect to "pets/#{@pet.id}"
  end
  
end


# patch '/pets/:id' do 
#     # if !params[:owner].keys.include?("pet_ids")
#     #   params[:owner]["pet_ids"] = []
#     # end 
    
#     @pet = Pet.find(params[:pet][:owner_id])
#     @pet.update(params["pet"])
#     if !params["owner"]["name"].empty?
#       @pet.owner = Owner.create(name: params["owner"]["name"])
#     else 
#       @pet.owner = Owner.find_by_id(params[:pet][:owner_id])
#     end 
#     redirect to "pets/#{@pet.id}"
#   end


  # patch '/pets/:id' do 
  #   # if !params[:owner].keys.include?("pet_ids")
  #   #   params[:owner]["pet_ids"] = []
  #   # end 
    
  #   @pet = Pet.find(params[:pet][:owner_id])
  #   @pet.update(params["pet"])
  #   if !params["owner"]["name"].empty?
  #     @pet.owner = Owner.create(name: params["owner"]["name"])
  #   else 
  #     @pet.owner = Owner.find_by_id(params[:pet][:owner_id])
  #   end 
  #   @pet.save
  #   redirect to "pets/#{@pet.id}"
  # end
  
# end 