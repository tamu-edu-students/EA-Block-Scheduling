# /db/seeds/user_data.rb
ActiveRecord::Base.transaction do
  roles = [
    { name: "admin" },
    { name: "student" },
    { name: "mixed" }
  ]

  users = [
    { email: "adithis197@gmail.com", first_name: "Adithi", last_name: "Srinath", role: "admin", uid: "116500254308898725555", provider: "google_oauth2" },
    { email: "adithis_197@tamu.edu", first_name: "Adithi", last_name: "Srinath", role: "", uid: "109257166036787184451", provider: "google_oauth2" },
    { email: "aaron.h.jones@tamu.edu", first_name: "Aaron", last_name: "Jones", role: "admin", uid: "100395242124242398599", provider: "google_oauth2" },
    { email: "aaronjons820@gmail.com", first_name: "Aaron", last_name: "Jones", role: "", uid: "115626303286117069601", provider: "google_oauth2" }
  ]

  user_roles = [
    { user_id: 1, role_id: 1 },
    { user_id: 1, role_id: 1 },
    { user_id: 2, role_id: 1 },
    { user_id: 2, role_id: 2 }
  ]

  roles.each do |role|
    Role.find_or_create_by(name: role[:name]) do |r|
      r.name = role[:name]
    end
  end

  users.each do |user|
    User.find_or_create_by(email: user[:email]) do |u|
      u.email = user[:email]
      u.first_name = user[:first_name]
      u.last_name = user[:last_name]
      u.role = user[:role]
      u.uid = user[:uid]
      u.provider = user[:provider]
    end
  end

  user_roles.each do |user_role|
    UserRole.find_or_create_by(user_id: user_role[:user_id], role_id: user_role[:role_id]) do |u|
      u.user_id = user_role[:user_id]
      u.role_id = user_role[:role_id]
    end
  end
end
