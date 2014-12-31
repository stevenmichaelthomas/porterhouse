require 'animation'
require 'compass'
require 'htmlentities'
require 'susy'
require 'ostruct'

require 'lib/sass_extensions.rb'

activate :dotenv

#-----------------------------------------------------------------------------
# Helpers
#-----------------------------------------------------------------------------

helpers do
end

#-----------------------------------------------------------------------------
# Plugins & Deployment
#-----------------------------------------------------------------------------

activate :directory_indexes
page '/404.html',    directory_index: false
page '/sitemap.xml', directory_index: false

#-----------------------------------------------------------------------------
# Build
#-----------------------------------------------------------------------------

configure :build do
  activate :gzip

  activate :asset_hash

  activate :minify_css
  activate :minify_javascript

  if ENV['DEPLOY_BRANCH']
    set :build_dir, "build/#{ ENV['DEPLOY_BRANCH'] }"
    set :http_prefix, "/#{ ENV['DEPLOY_BRANCH'] }"
  else
    set :http_prefix, '/'
  end
end

Fog.credentials = { path_style: true }

activate :sync do |sync|
  sync.fog_provider = 'AWS'
  sync.fog_directory = ENV['DEPLOY_BUCKET']
  sync.fog_region = 'us-west-2'
  sync.aws_access_key_id = ENV['AWS_ACCESS_KEY_ID']
  sync.aws_secret_access_key = ENV['AWS_SECRET_ACCESS_KEY']
  sync.existing_remote_files = 'keep'
  sync.gzip_compression = true
  sync.after_build = true
end
