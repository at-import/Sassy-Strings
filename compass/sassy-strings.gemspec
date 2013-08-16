# -*- encoding: utf-8 -*-
require './lib/sassy-strings'

Gem::Specification.new do |s|
  # General Project Information
  s.name = "sassy-strings"
  s.version = SassyStrings::VERSION
  s.date = SassyStrings::DATE
  s.rubyforge_project = "sassy-strings"
  s.rubygems_version = "1.7.2"
  s.required_rubygems_version = Gem::Requirement.new(">= 1.2")

  # Author Information
  s.authors = ["Sam Richard"]
  s.email = ["snugug@gmail.com"]
  s.homepage = "https://github.com/snugug/sassy-strings"

  # Project Description
  s.description = "Superpower Strings!"
  s.summary = "Advanced String handling for Sass"
  s.license = "MIT"

  # Files to Include
  s.files  =  Dir.glob("lib/**/*.*")
  # s.files +=  Dir.glob("stylesheets/**/*.*")
  # s.files +=  Dir.glob("templates/**/*.*")

  # Dependent Gems

  s.add_dependency("compass",           [">= 0.12.2"])
end