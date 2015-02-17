module UsersHelper
  def ice_button(user)
    ice = link_to('freeze account', url_for([:ice_account, user.id]), method: :post, class:"btn-sm btn-danger")
    raw("#{ice}")
  end
end
