json.id comment.id
json.created_at comment.created_at.strftime("%m/%d/%Y at %I:%M %p").downcase
json.user comment.user.short_name if comment.user
json.text comment.text
