require 'zip'
class GeneratorArchive

  def self.create_zip files_name
    folder = "#{Rails.root}/public/diploms"
    zipfile_name = "#{Rails.root}/public/diploms/archive_#{Time.now.strftime('%H:%M:%S_%m%d%Y')}.zip"

    Zip::File.open(zipfile_name, Zip::File::CREATE) do |zipfile|
      files_name.each do |filename|
        zipfile.add(filename, File.join(folder, filename))
      end
    end

    zipfile_name
  end
end