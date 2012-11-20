assets_are_in ENV['ASSET_PATH']

asset 'titan.js' do |a|
  a.scan 'scripts/coffee', 'scripts/js'
  a.toolchain :coffeescript, :require
  a.post_build :closure
end

asset 'titan.css' do |a|
  a.scan 'styles/scss', 'styles/css'
  a.toolchain :sassy
end