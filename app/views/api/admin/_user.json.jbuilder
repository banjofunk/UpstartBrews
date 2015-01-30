json.id user.id
json.first_name user.first_name
json.last_name user.last_name
json.email user.email
json.created_at user.created_at.to_s.split(' ')[0]
json.roles user.roles
