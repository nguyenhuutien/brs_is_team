module ApplicationHelper
  def link_to_object activity
    object = binding.eval("#{activity.trackable_type}.find_by_id activity.trackable_id")
    if object.nil?
      link_to "#", root_path
    else
      if activity.trackable_type == "Book"
        link_to truncate(object.title, length: Settings.activity_length), object, title: object.title
      elsif activity.trackable_type == "Review"
        link_to truncate(object.content, length: Settings.activity_length), object,
          title: truncate(object.content, length: Settings.content_length)
      else
        link_to truncate(object.name, length: Settings.activity_length), object,
          title: object.name
      end
    end
  end
end
