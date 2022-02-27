class DataUploaderService
  attr_accessor :file, :status

  def initialize(id)
    @file = FileTracker.find(id)
  end

  def uploader(data)
    file.update(status: 'PROCESSING')
    upload(data)
  end

  # This has to be hanled asunchronously as seperate process
  def upload(data)
    processed_data = file.data.pluck(:name)
    FileDatum.transaction do
      (data - processed_data).each do |datum|
        sleep 1
        file.data.create(name: datum, email: "#{datum.downcase}@chainbrain.com") if can_upload?
        raise ActiveRecord::Rollback if status == 'STOPPED'
        raise ActiveRecord::RecordInvalid if status == 'KILLED'
      end
      file.update(status: 'PROCESSED')
    rescue ActiveRecord::RecordInvalid => e
      p 'Process Killed'
    end
  end

  # This is to check whether we get any stop or kill request
  # Ideally this flag has to be set in Redis or cache layer instead of DB
  def can_upload?
    @status = file.reload.status
    %w[STOPPED KILLED].exclude?(status)
  end

end

