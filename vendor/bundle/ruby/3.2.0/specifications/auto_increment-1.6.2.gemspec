# -*- encoding: utf-8 -*-
# stub: auto_increment 1.6.2 ruby lib

Gem::Specification.new do |s|
  s.name = "auto_increment".freeze
  s.version = "1.6.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Felipe Diesel".freeze]
  s.date = "2024-05-19"
  s.description = "Automaticaly increments an ActiveRecord column".freeze
  s.email = ["diesel@hey.com".freeze]
  s.homepage = "http://github.com/felipediesel/auto_increment".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.4.20".freeze
  s.summary = "Auto increment a string or integer column".freeze

  s.installed_by_version = "3.4.20" if s.respond_to? :installed_by_version

  s.specification_version = 4

  s.add_runtime_dependency(%q<activerecord>.freeze, [">= 6.0"])
  s.add_runtime_dependency(%q<activesupport>.freeze, [">= 6.0"])
  s.add_development_dependency(%q<bundler>.freeze, [">= 0"])
  s.add_development_dependency(%q<rake>.freeze, [">= 0"])
  s.add_development_dependency(%q<appraisal>.freeze, [">= 0"])
  s.add_development_dependency(%q<database_cleaner>.freeze, [">= 0"])
  s.add_development_dependency(%q<fuubar>.freeze, [">= 0"])
  s.add_development_dependency(%q<guard>.freeze, [">= 0"])
  s.add_development_dependency(%q<guard-rspec>.freeze, [">= 0"])
  s.add_development_dependency(%q<rspec>.freeze, [">= 0"])
  s.add_development_dependency(%q<rspec-nc>.freeze, [">= 0"])
  s.add_development_dependency(%q<rubocop>.freeze, [">= 0"])
  s.add_development_dependency(%q<sqlite3>.freeze, [">= 1.3.13"])
end
