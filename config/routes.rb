Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  controller :pages do
    get :qr_code_generator
    get :qr_code_download
    get :qr_code_with_logo
  end

end
