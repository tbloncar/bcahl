class BulletinsController < ApplicationController
  def update
    authorize_action!
    @bulletin = Bulletin.first

    if @bulletin.update(bulletin_params)
      redirect_to user_url(current_user.path),
        success: "You updated the bulletin!"
    else
      redirect_to user_url(current_user.path),
        notice: "Hm. Something went awry."
    end
  end

  private

  def bulletin_params
    params.require(:bulletin).permit(:message, :active)
  end
end
