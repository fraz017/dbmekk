ActiveAdmin.register Event, as: "Bookings" do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end
  index do
    selectable_column
    column :title
    column :email
    column :license_no
    column :phone_number
    column :start
    column :end
    column :description
    column :bill do |event| 
      if event.bill.present?
        link_to "View Bill", "/generate_bill/#{event.bill.id}", target: "_blank"
      else
        link_to "Generate Bill", new_admin_bill_path({event_id: event.id}), target: "_blank"
      end
    end
    actions
  end
end
