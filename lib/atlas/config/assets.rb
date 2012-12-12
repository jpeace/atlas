assets_are_in ENV['ATLAS_ASSET_PATH']
add_tools ::Atlas::Keystone::AssetTools

asset 'atlas.js' do |a|
  a.scan 'coffee', 'js'
  a.toolchain :export_platform_symbols, :coffeescript, :require
  a.post_build :closure
end