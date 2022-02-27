class DataUploadController < ApplicationController
  before_action :set_file, only: %i[stop kill show status]

  def upload
    FileTracker.where(id: params[:file_id]).first_or_create(status: 'INITIALIZING')
    DataUploaderService.new(params[:file_id]).uploader(params[:data] || sample_data)
    status = FileTracker.find(params[:file_id]).status
    render status: :ok, json: { message: "file upload got #{status.downcase}" }
  end

  def stop
    @file.update(status: 'STOPPED')
    render status: :ok, json: { message: 'stopped successfully' }
  end

  def kill
    @file.update(status: 'KILLED')
    render status: :ok, json: { message: 'killed successfully' }
  end

  def clean
    FileDatum.delete_all
    render json: { message: 'success' }
  end

  def status
    render status: :ok, json: { status: @file.status }
  end

  def show; end

  def generate_data
    data = []
    count = params[:count] || 100
    count.times do
      data << Faker::Name.first_name
    end
    data
  end

  def sample_data
    %w[Nivedhan Manas Sharang Karthik Yuri Wallace Dorene Murray Emmett Evalyn Elsy Rodrick Will Lynda Jene Archie Leroy Kristeen Deirdre Fairy Jenette Dallas Maile Chet Ty Florencia Hassan Anissa Deandrea Emily Tawnya Augustine Oretha Demetrius Ginny Lyle Lucille Cletus Bobby Willard Dexter Abby Arnette Luetta Anibal Chantal Candy Son Kristofer Shandi Blair Rodolfo Lauretta Kermit Marybeth Dewayne Chauncey Gay Reba Kiley Lucinda Linnie Linn Elayne]
  end

  private

  def set_file
    @file = FileTracker.find(params[:file_id])
  rescue ActiveRecord::RecordNotFound => e
    render status: :not_found, json: { message: 'File Not found' }
  end
end
