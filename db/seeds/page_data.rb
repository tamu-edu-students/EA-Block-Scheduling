# /db/seeds/page_data.rb

ActiveRecord::Base.transaction do
  pages = [
    { url_path: "admin" }, # 1
    { url_path: "courses" }, # 2
    { url_path: "excel_files" }, # 3
    { url_path: "layouts" }, # 4
    { url_path: "pages" }, # 5
    { url_path: "pwa" }, # 6
    { url_path: "schedules" }, # 7
    { url_path: "sessions" }, # 8
    { url_path: "shared" }, # 9
    { url_path: "students" }, # 10
    { url_path: "user_roles" }, # 11
    { url_path: "users" }, # 12
    { url_path: "welcome" } # 13
  ]

  page_role_accesses = [
    { page_id: 1, role_id: 1 },
    { page_id: 2, role_id: 3 },
    { page_id: 3, role_id: 1 },
    { page_id: 4, role_id: 3 },
    { page_id: 5, role_id: 1 },
    { page_id: 6, role_id: 3 },
    { page_id: 7, role_id: 1 },
    { page_id: 8, role_id: 3 },
    { page_id: 9, role_id: 1 },
    { page_id: 10, role_id: 1 },
    { page_id: 11, role_id: 1 },
    { page_id: 12, role_id: 3 },
    { page_id: 13, role_id: 1 }
  ]

  pages.each do |page|
    Page.find_or_create_by!(url_path: page[:url_path]) do |p|
      p[:url_path] = page[:url_path]
    end
  end

  page_role_accesses.each do |page_role|
    PageRoleAccess.find_or_create_by!(page_id: page_role[:page_id], role_id: page_role[:role_id]) do |pr|
      pr[:page_id] = page_role[:page_id]
      pr[:role_id] = page_role[:role_id]
    end
  end
end
