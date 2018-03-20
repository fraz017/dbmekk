ActiveAdmin.register Bill do

  form do |f|
    render partial: "form", locals: { f: f}
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
        redirect_to "/generate_bill/#{@bill.id}.pdf" and return
      end
    end 
  end

end