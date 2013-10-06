class ProcessAccount
  include Sidekiq::Worker
  def perform(credentials, user, domain)
    importer_class = Importer.class_eval(domain.classify)
    importer = importer_class.new(credentials)
    importer.process_account(user)
  end
end