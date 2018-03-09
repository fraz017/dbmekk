ActiveAdmin.register Event, as: "Bookings" do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
  config.clear_action_items!
  action_item :only => :index do
    link_to "New Booking" , "/admin/dashboard" 
  end
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
        columns do 
          column do
            link_to "View Bill", "/generate_bill/#{event.bill.id}", target: "_blank"
          end
          column do
            link_to "Edit Bill", "/admin/bills/#{event.bill.id}/edit", target: "_blank"
          end
        end
      else
        link_to "Generate Bill", new_admin_bill_path({event_id: event.id}), target: "_blank"
      end
    end
    actions
  end

  form do |f|
    f.inputs do
      f.input :title
      f.input :email
      f.input :license_no
      f.input :phone_number
      f.input :start, :input_html => { :value => params[:start] }, as: :hidden
      f.input :end, :input_html => { :value => params[:end] }, as: :hidden
      f.input :description
    end
    f.inputs "Services", for: [:bill, f.object.bill || Bill.new] do |meta_form|
      meta_form.input :services, as: :check_boxes
    end
    f.actions
  end
end
