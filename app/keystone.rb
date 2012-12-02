module Titan
  module Keystone
    module AssetTools
      class ExportPlatformSymbols
        include ::Keystone::AssetTool

        def initialize
          @platform_namespaces = ['core', 'presenters']
        end
        def should_run?(asset)
          asset.type == ::Keystone::Types::Coffeescript && @platform_namespaces.any? {|ns| asset.path[/^#{ns}/]}
        end
        def transform(asset)
          namespace = @platform_namespaces.find {|ns| asset.path[/^#{ns}/]}
          raise "Could not find platform namespace for #{asset.name}" if namespace.nil?

          "titan.#{namespace}.#{class_name_from_asset_name(asset.name)} = #{asset.content}"
        end

        private

        def class_name_from_asset_name(asset_name)
          asset_name.capitalize.gsub(/_([a-z])/) {$1.upcase}
        end
      end
    end
  end
end