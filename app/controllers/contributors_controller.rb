class ContributorsController < ApplicationController
  before_action :clear_files, only: [:active_contributors]

  def active_contributors
    if params[:repos_url]
      @contributors = Repository.get_contibutors_with_pdf(params[:repos_url])
      @zip_file = GeneratorArchive.create_zip(@contributors.values) if @contributors
    end
  end

  def download_pdf
    send_file(
        "#{Rails.root}/public/diploms/#{params[:file_name]}",
        type: 'application/pdf'
    )
  end

  def download_zip
    send_file("#{params[:file_url]}")
  end

  private

  def clear_files
    FileUtils.rm_rf(Dir["#{Rails.root}/public/diploms/*"])
  end

end