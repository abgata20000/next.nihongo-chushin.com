require_relative 'boot'

require 'rails/all'


# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module NextNihongoChushinCom
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    config.generators do |g|
      g.orm             :active_record
      g.template_engine :slim
      g.stylesheets     false
      g.javascripts     false
      g.test_framework :rspec, fixture: true, fixture_replacement: :factory_girl
      g.view_specs false
      g.controller_specs false
      g.routing_specs false
      g.helper_specs false
      g.request_specs false
      g.helper false
    end

    config.active_job.queue_adapter = :sidekiq

    config.active_record.default_timezone = :local
    config.time_zone = "Tokyo"
    I18n.enforce_available_locales = true
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :ja
    config.beginning_of_week = :sunday

    config.paths.add 'lib', eager_load: true
    config.eager_load_paths += Dir[Rails.root.join('app', 'services', 'concerns')]
    config.eager_load_paths += Dir[Rails.root.join('app', 'decorators', 'concerns')]
    config.eager_load_paths += Dir[Rails.root.join('app', 'uploaders', 'concerns')]

    def inspect
      "#<#{self.class}>"
    end

  end
end
