ActiveAdmin.register Service do
  index do
    selectable_column 
    column :id
    column :name
    column :price
    column :tax
    column :grand_total
    actions
  end
end