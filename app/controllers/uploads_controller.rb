class UploadsController < ActionController::Base
  
  def upload_profile_picture
    resource = current_user
    resource.profile_picture.attach(params[:profile_picture])

    if resource.save
      flash[:notice] = "Profile picture updated successfully!"
      redirect_to profile_path(resource)
    else
      flash[:alert] = "Could not update profile picture!"
      redirect_to profile_path(resource)
    end

  end

  def upload_cover_picture
    resource = current_user

    resource.cover_picture.attach(params[:cover_picture])

    if resource.save
      flash[:notice] = "Cover picture updated successfully!"
      redirect_to profile_path(resource)
    else
      flash[:alert] = "Could not update Cover picture!"
      redirect_to profile_path(resource)
    end
  end
end
