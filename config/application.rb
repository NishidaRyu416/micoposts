require File.expand_path('../boot', __FILE__)

require 'rails/all'


Bundler.require(*Rails.groups)

module Microposts
  class Application < Rails::Application
    
    config.active_record.raise_in_transactional_callbacks = true
module Microposts
  class Application < Rails::Application
  # 中略

    config.generators do |g|
      g.stylesheets false
      g.javascripts false
      g.helper false
      g.test_framework false
    end
  end
end
   config.action_view.embed_authenticity_token_in_remote_forms = true #追加部分
  end
end