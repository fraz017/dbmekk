ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  controller do
    layout 'active_admin' # <-- here
    def index
      
    end
  end
end
