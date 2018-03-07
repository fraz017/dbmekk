ActiveAdmin.register Bill do

  form do |f|
    f.inputs do
      f.input :event, selected: params[:event_id] || f.object.try(:event).try(:id), :input_html => { :readonly => true }
      f.input :services, as: :check_boxes
      f.has_many :items, heading: 'Others', allow_destroy: true do |a|
        a.input :name
        a.input :price
      end
    end
    f.actions
  end

  index do
    selectable_column 
    column :id
    column "Booking", :event
    column :price
    column :tax
    column :grand_total
    actions
  end

  controller do
    
    def create
      super do |format|
        redirect_to "/generate_bill/#{@bill.id}" and return
      end
    end 
  end

end