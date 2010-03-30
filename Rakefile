require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "mm-embeddable"
    gem.summary = %Q{Create compact, embeddable versions of your MongoMapper documents.}
    gem.description = %Q{For query minimization purposes in MongoDB it is useful to provide a few key properties of a document when it's embedded in another one. MongoMapper Embeddable is a plugin for MongoMapper to do just that.}
    gem.email = "michael@intridea.com"
    gem.homepage = "http://github.com/intridea/mm-embeddable"
    gem.add_dependency 'mongo_mapper', '>= 0.7.0'
    gem.authors = ["Michael Bleigh"]
    gem.add_development_dependency "rspec", ">= 1.2.9"
    gem.add_development_dependency 'mocha'
    gem.add_development_dependency 'machinist'
    gem.add_development_dependency 'machinist_mongo'
    gem.add_development_dependency 'faker'
    
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.spec_files = FileList['spec/**/*_spec.rb']
end

Spec::Rake::SpecTask.new(:rcov) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :spec => :check_dependencies

task :default => :spec

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "mm_compactable #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
