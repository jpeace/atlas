  s.name = "atlas"
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Music One Live"]
  s.date = "2012-12-12"
  s.description = "UI Framework"
  s.email = "admin@musiconelive.com"
  s.extra_rdoc_files = ["lib/atlas.rb", "lib/atlas/config/assets.rb", "lib/atlas/config/environment.rb", "lib/atlas/support/keystone.rb", "lib/atlas/version.rb"]
  s.files = ["Gemfile", "Gemfile.lock", "Rakefile", "lib/atlas.rb", "lib/atlas/config/assets.rb", "lib/atlas/config/environment.rb", "lib/atlas/support/keystone.rb", "lib/atlas/version.rb", "spec/atlas/core/binding/binding_expression_spec.coffee", "spec/atlas/core/binding/binding_spec.coffee", "spec/atlas/core/view_spec.coffee", "spec/atlas/titan_spec.coffee", "spec/spec_helper.coffee", "spec/support/jasmine.yml", "src/coffee/bootstrap.coffee", "src/coffee/core/amplify.coffee", "src/coffee/core/binding.coffee", "src/coffee/core/binding/binder.coffee", "src/coffee/core/binding/binding_expression.coffee", "src/coffee/core/binding/bindings/background_color.coffee", "src/coffee/core/binding/bindings/base.coffee", "src/coffee/core/binding/bindings/class.coffee", "src/coffee/core/binding/bindings/display.coffee", "src/coffee/core/patches.coffee", "src/coffee/core/presenter.coffee", "src/coffee/core/view.coffee", "src/coffee/presenters/user_details.coffee", "src/coffee/titan.coffee", "src/js/lib/amplify-1.1.0.js", "src/js/lib/jquery-1.8.3.js", "src/js/lib/underscore-1.4.2.js", "Manifest", "atlas.gemspec"]
  s.homepage = "http://musiconelive.com"
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Atlas"]
  s.require_paths = ["lib"]
  s.rubyforge_project = "atlas"
  s.rubygems_version = "1.8.10"
  s.summary = "UI Framework"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
