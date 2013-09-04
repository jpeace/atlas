module Atlas
  module Keystone
    @@compiler = nil
    def self.compiler
      if @@compiler.nil?
        @@compiler = ::Keystone.bootstrap("#{File.expand_path(File.dirname(__FILE__))}/../config/assets.rb").compiler('atlas.js')
      end
      @@compiler
    end

    module AssetTools
      class ExportPlatformSymbols
        include ::Keystone::AssetTool

        def initialize
          @platform_namespaces = ['core', 'binding']
        end
        def should_run?(asset)
          asset.type == ::Keystone::Types::Coffeescript && @platform_namespaces.any? {|ns| asset.path[/^atlas\/#{ns}/]}
        end
        def transform(asset)
          namespace = asset.path.gsub(/^atlas\//, '').gsub('/', '.')
          "atlas.ensureNamespace('#{namespace}').#{class_name_from_asset_name(asset.name)} = #{asset.content}"
        end

        private

        def class_name_from_asset_name(asset_name)
          asset_name.capitalize.gsub(/_([a-z])/) {$1.upcase}
        end
      end
    end
  end
end