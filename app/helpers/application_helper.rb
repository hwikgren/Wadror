module ApplicationHelper

  def edit_and_destroy_buttons(item)
    unless current_user.nil?
      edit = link_to('Edit', url_for([:edit, item]), class:"btn-sm btn-primary")
      if current_user.admin
        del = link_to('Delete', item, method: :delete, data: {confirm: 'Are you sure?' }, class:"btn-sm btn-danger")
      else
        del = ""
      end
      raw("#{edit} #{del}")
    end
  end

  def edit_and_back_buttons(item, item2)
    unless current_user.nil?
      edit = link_to('Edit', url_for([:edit, item]), class:"btn-sm btn-primary")
      back = link_to('Back', url_for(item2), class:"btn-sm btn-primary")
      raw("#{edit} #{back}")
    end
  end

  def round(param)
    rounded = number_with_precision(param, precision: 1)
    raw("#{rounded}")
  end
end
