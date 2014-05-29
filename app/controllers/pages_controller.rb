class PagesController < ApplicationController

  def index
    @bulletin = Bulletin.first
  	@photos = Photo.latest
  	@upcoming_events = Event.upcoming
  	@upcoming_games = Game.upcoming
  	@recent_games = Game.recent

  	@title = "BCAHL | Beaver County Adult Hockey League"
  	@meta_description = "The BCAHL is an adult hockey league and clinic run out of the Beaver County Ice Arena in Brady's Run Park."
  end

  def calendar
  	@events = Game.all + Event.all
  	@date = params[:month] ? Date.parse(params[:month]) : Date.today

  	@title = "League Calendar | Beaver County Adult Hockey League"
  	@meta_description = "Check out upcoming games and events on the BCAHL's league calendar."
  	@canonical = "http://www.bcahl.net/calendar"
  end

  def about
  	@title = "About Our League | Beaver County Adult Hockey League"
  	@meta_description = "Learn about what goes on in the Beaver County Adult Hockey League."
  end

  def contact
  	@title = "Contact Us | Beaver County Adult Hockey League"
  	@meta_description = "Interested in joining our league or becoming a sponsor? Contact the Beaver County Adult Hockey League."
  end
end
