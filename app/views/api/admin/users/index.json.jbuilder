json.all_roles User::ROLES
json.users do
  json.array! @users, partial: 'user', as: :user
end
