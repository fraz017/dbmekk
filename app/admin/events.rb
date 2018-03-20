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
  controller do
    def update
      update! do |format|
        format.html { redirect_to admin_dashboard_path }
      end
    end
    def create
      create! do |format|
        format.html { redirect_to admin_dashboard_path }
      end
    end
  end

  index do
    selectable_column
    column :title
    column :email
    column :license_no
    column :phone_number
    column :start
    column :booking_time do |e|
      e.booking_time&.strftime("%I:%M %P")
    end
    column :description
    column :bill do |event| 
      if event.bill.present?
        columns do 
          column do
            link_to "View Bill", "/generate_bill/#{event.bill.id}.pdf", target: "_blank"
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
      f.input :title, placeholder: "Title"
      f.input :email, placeholder: "Email Address"
      f.input :license_no, placeholder: "AA-55555"
      f.input :phone_number, placeholder: "12345678"
      f.input :booking_time, :as => :time_picker, placeholder: ""
      f.input :start, :input_html => { :value => f.object.start || params[:start] }, as: :hidden
      f.input :end, :input_html => { :value => f.object.end || params[:end] }, as: :hidden
      f.input :description, placeholder: "Description"
    end
    f.inputs "Services", for: [:bill, f.object.bill || Bill.new] do |meta_form|
      meta_form.input :services, as: :check_boxes
    end
    f.actions
    f.html do |b|
      if params[:action] == "edit"
        @event = Event.find_by(id: params[:id])
        if @event.bill.present?
          div class: "col-md-2" do
            link_to "View Bill", "/generate_bill/#{@event.bill.id}.pdf", class: "btn btn-primary"
          end
          div class: "col-md-2" do
            link_to "Edit Bill", "/admin/bills/#{@event.bill.id}/edit", class: "btn btn-primary"
          end
        else
          div do
            link_to "Generate Bill", new_admin_bill_path({event_id: @event.id}), class: "btn btn-primary"
          end
        end
      end
    end
  end
end
