require File.expand_path('../boot', __FILE__)

require 'rails/all'
Bundler.require(*Rails.groups)
Elasticsearch::Model.client = Elasticsearch::Client.new host: ENV['BONSAI_URL'] || ENV['SEARCHBOX_URL']

module TownParlament
  class Application < Rails::Application
    config.active_record.raise_in_transactional_callbacks = true
    config.autoload_paths << Rails.root.join('lib')
  end
end
