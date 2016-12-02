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

  def link_to_remove_fields name, f
    f.hidden_field(:_destroy) + link_to(name, "remove_fields(this)")
  end

  def link_to_add_fields f, association
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + "_fields", f: builder)
    end
    link_to ("<span class='glyphicon glyphicon-plus small'>AddAuthor</span>").html_safe,
      "#", class: "add_fields", data: {id: id, fields: fields.gsub("\n", "")}
  end
end