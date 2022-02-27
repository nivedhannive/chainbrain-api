class FileDatum < ApplicationRecord
  self.table_name = 'file_data'
  belongs_to :file_tracker, class_name: 'FileTracker', inverse_of: :data
end
