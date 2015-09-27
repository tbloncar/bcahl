FactoryGirl.define do
  factory :bulletin do
    message "MyText"
  end

  factory :gallery do
    name "MyString"
    description "MyText"
    date_start "2013-09-21"
    date_end "2013-09-21"
  end

  factory :player do
    f_name "Mario"
    l_name "Lemieux"
  end

  factory :team do
    color "Black"
  end

  factory :league do
    name "NHL"
  end

  factory :season do
    name "2015 / 2016"
    league
  end

  factory :roster do
    season
    team
  end

  factory :roster_spot do
    player
    roster
    captain true
  end

  factory :game do
    season
    date_and_time DateTime.now
  end
end
