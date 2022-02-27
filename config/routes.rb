Rails.application.routes.draw do
  get 'show', to: 'data_upload#show'
  post 'upload', to: 'data_upload#upload'
  put 'stop', to: 'data_upload#stop'
  put 'kill', to: 'data_upload#kill'
  get 'generate_data', to: 'data_upload#generate_data'
  get 'status', to: 'data_upload#status'
end
