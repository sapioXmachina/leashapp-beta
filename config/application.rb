require_relative "boot"

require "rails/all"

require "tzinfo"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module HelloApp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0
    
    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    config.time_zone = ENV["TIMEZONE"]
    # config.active_record.default_timezone = :local
    # config.eager_load_paths << Rails.root.join("extras")
    
    config.exceptions_app = self.routes # Add this line
    
    # config.web_console.permissions = ENV['WEBCONSOLE']
    
    # config.autoload_paths += %W(#{config.root}/lib)
    
    config.before_configuration do
      env_file = File.join(Rails.root, 'config', 'local_env.yml')
      YAML.load(File.open(env_file)).each do |key, value|
        ENV[key.to_s] = value
      end if File.exists?(env_file)
    end
  end
end
