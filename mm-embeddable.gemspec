# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{mm-embeddable}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Michael Bleigh"]
  s.date = %q{2011-03-09}
  s.description = %q{For query minimization purposes in MongoDB it is useful to provide a few key properties of a document when it's embedded in another one. MongoMapper Embeddable is a plugin for MongoMapper to do just that.}
  s.email = %q{michael@intridea.com}
  s.extra_rdoc_files = ["README.rdoc"]
  s.files = ["LICENSE", "mm-embeddable.gemspec", "Rakefile", "README.rdoc", "VERSION", "spec/blueprints.rb", "spec/mm_embeddable_spec.rb", "spec/spec.opts", "spec/spec_helper.rb", "lib/mm-embeddable.rb"]
  s.homepage = %q{http://github.com/intridea/mm-embeddable}
  s.rdoc_options = ["--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.4.1}
  s.summary = %q{Create compact, embeddable versions of your MongoMapper documents.}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<mongo_mapper>, [">= 0.9.0"])
      s.add_development_dependency(%q<rspec>, [">= 0"])
      s.add_development_dependency(%q<mocha>, [">= 0"])
      s.add_development_dependency(%q<machinist>, [">= 0"])
      s.add_development_dependency(%q<machinist_mongo>, [">= 0"])
      s.add_development_dependency(%q<faker>, [">= 0"])
    else
      s.add_dependency(%q<mongo_mapper>, [">= 0.9.0"])
      s.add_dependency(%q<rspec>, [">= 0"])
      s.add_dependency(%q<mocha>, [">= 0"])
      s.add_dependency(%q<machinist>, [">= 0"])
      s.add_dependency(%q<machinist_mongo>, [">= 0"])
      s.add_dependency(%q<faker>, [">= 0"])
    end
  else
    s.add_dependency(%q<mongo_mapper>, [">= 0.9.0"])
    s.add_dependency(%q<rspec>, [">= 0"])
    s.add_dependency(%q<mocha>, [">= 0"])
    s.add_dependency(%q<machinist>, [">= 0"])
    s.add_dependency(%q<machinist_mongo>, [">= 0"])
    s.add_dependency(%q<faker>, [">= 0"])
  end
end
