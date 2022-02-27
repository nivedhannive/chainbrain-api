class FileTracker < ApplicationRecord
  self.table_name = 'file_trackers'

  has_many :data, class_name: 'FileDatum', inverse_of: :file_tracker, dependent: :delete_all
end
