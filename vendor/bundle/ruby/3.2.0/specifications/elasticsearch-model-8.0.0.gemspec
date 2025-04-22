# -*- encoding: utf-8 -*-
# stub: elasticsearch-model 8.0.0 ruby lib

Gem::Specification.new do |s|
  s.name = "elasticsearch-model".freeze
  s.version = "8.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Elastic Client Library Maintainers".freeze]
  s.date = "2024-05-30"
  s.description = "ActiveModel/Record integrations for Elasticsearch.".freeze
  s.email = ["client-libs@elastic.co".freeze]
  s.extra_rdoc_files = ["README.md".freeze, "LICENSE.txt".freeze]
  s.files = ["LICENSE.txt".freeze, "README.md".freeze]
  s.homepage = "https://github.com/elasticsearch/elasticsearch-rails/".freeze
  s.licenses = ["Apache 2".freeze]
  s.rdoc_options = ["--charset=UTF-8".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 3".freeze)
  s.rubygems_version = "3.4.20".freeze
  s.summary = "ActiveModel/Record integrations for Elasticsearch.".freeze

  s.installed_by_version = "3.4.20" if s.respond_to? :installed_by_version

  s.specification_version = 4

  s.add_runtime_dependency(%q<activesupport>.freeze, ["> 3"])
  s.add_runtime_dependency(%q<elasticsearch>.freeze, ["~> 8"])
  s.add_runtime_dependency(%q<hashie>.freeze, [">= 0"])
  s.add_development_dependency(%q<activemodel>.freeze, ["> 3"])
  s.add_development_dependency(%q<bundler>.freeze, [">= 0"])
  s.add_development_dependency(%q<cane>.freeze, [">= 0"])
  s.add_development_dependency(%q<kaminari>.freeze, [">= 0"])
  s.add_development_dependency(%q<minitest>.freeze, [">= 0"])
  s.add_development_dependency(%q<mocha>.freeze, [">= 0"])
  s.add_development_dependency(%q<pry>.freeze, [">= 0"])
  s.add_development_dependency(%q<rake>.freeze, ["~> 12"])
  s.add_development_dependency(%q<require-prof>.freeze, [">= 0"])
  s.add_development_dependency(%q<shoulda-context>.freeze, [">= 0"])
  s.add_development_dependency(%q<simplecov>.freeze, [">= 0"])
  s.add_development_dependency(%q<test-unit>.freeze, [">= 0"])
  s.add_development_dependency(%q<turn>.freeze, [">= 0"])
  s.add_development_dependency(%q<will_paginate>.freeze, [">= 0"])
  s.add_development_dependency(%q<yard>.freeze, [">= 0"])
  s.add_development_dependency(%q<oj>.freeze, [">= 0"])
  s.add_development_dependency(%q<ruby-prof>.freeze, [">= 0"])
  s.add_development_dependency(%q<sqlite3>.freeze, ["~> 1.4"])
end
