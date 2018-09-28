class Repository < ApplicationRecord

  has_many :contributors


  def self.get_contibutors_with_pdf repos_url
    contributors = Github.get_contributors(repos_url)
    return nil unless contributors
    # просто сохраняем репозиторий и контрибьюторов (ниже)
    repos_id = Repository.find_or_create_by(name: contributors[:repos_name]).id
    contributors_with_pdf = {}
    contributors[:users].each do |contributor|
      Contributor.find_or_create_by(name: contributor, repository_id: repos_id)
      file_name = "#{contributor}_#{Time.now.strftime('%H:%M:%S_%m%d%Y')}.pdf"
      GeneratorPdf.create_document(contributor, file_name)
      contributors_with_pdf[contributor] = file_name
    end

    contributors_with_pdf
  end


end