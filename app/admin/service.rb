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

  form do |f|
    f.inputs do
      f.input :name
      f.input :price
      f.input :tax
    end
    f.actions
  end
end