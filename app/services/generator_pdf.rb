require 'fileutils'

class GeneratorPdf


  def self.create_document contributor_name, file_name
    dir = "#{Rails.root}/public/diploms"
    FileUtils.mkdir_p(dir) unless File.directory?(dir)

    pdf = Prawn::Document.new do
      move_down 200
      font_size(42) { text 'Diploma', align: :center }
      font_size(32) { text 'The award goes to', align: :center }
      font_size(22) { text contributor_name, align: :center }
    end

    pdf.render_file File.join(Rails.root, "public/diploms", file_name)
  end
end