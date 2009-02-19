# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{preen}
  s.version = "1.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Avdi Grimm"]
  s.date = %q{2009-02-19}
  s.default_executable = %q{preen}
  s.description = %q{preen (v) 3. To pride or congratulate oneself for achievement  A tool for spam^H^H^H^Hinforming your friends when you've been reddited.}
  s.email = %q{avdi@avdi.org}
  s.executables = ["preen"]
  s.extra_rdoc_files = ["History.txt", "Manifest.txt", "README.rdoc", "bin/preen", "test-accounts.txt"]
  s.files = [".gitignore", "History.txt", "Manifest.txt", "README.rdoc", "Rakefile", "bin/preen", "features/step_definitions/preen.rb", "features/support/env.rb", "features/support/html/reddit_page1.html", "features/support/html/reddit_page2.html", "features/support/html/reddit_page3.html", "features/support/html/reddit_page4.html", "features/support/stub_server.rb", "features/support/stubserver", "features/user_preens.feature", "lib/preen.rb", "lib/preen/application.rb", "lib/preen/mention.rb", "lib/preen/ping_fm.rb", "lib/preen/reddit.rb", "preen.gemspec", "spec/html/front_page.html", "spec/html/page2.html", "spec/html/page3.html", "spec/html/page4.html", "spec/preen/application_spec.rb", "spec/preen/ping_fm_spec.rb", "spec/preen/reddit_spec.rb", "spec/preen_spec.rb", "spec/spec_helper.rb", "tasks.archive/ann.rake", "tasks.archive/bones.rake", "tasks.archive/cucumber.rake", "tasks.archive/gem.rake", "tasks.archive/git.rake", "tasks.archive/manifest.rake", "tasks.archive/notes.rake", "tasks.archive/post_load.rake", "tasks.archive/rdoc.rake", "tasks.archive/rubyforge.rake", "tasks.archive/setup.rb", "tasks.archive/spec.rake", "tasks.archive/svn.rake", "tasks.archive/test.rake", "tasks/ann.rake", "tasks/bones.rake", "tasks/gem.rake", "tasks/git.rake", "tasks/notes.rake", "tasks/post_load.rake", "tasks/rdoc.rake", "tasks/rubyforge.rake", "tasks/setup.rb", "tasks/spec.rake", "tasks/svn.rake", "tasks/test.rake", "test-accounts.txt", "test/test_preen.rb", "tmp/home/.preen/preen.dat"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/avdi/preen}
  s.rdoc_options = ["--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{preen}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{preen (v) 3}
  s.test_files = ["test/test_preen.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<mechanize>, [">= 0.9.0"])
      s.add_runtime_dependency(%q<ick>, [">= 0.3.0"])
      s.add_runtime_dependency(%q<pingfm>, [">= 1.0.1"])
      s.add_development_dependency(%q<bones>, [">= 2.4.0"])
      s.add_development_dependency(%q<open4>, [">= 0.9.6"])
      s.add_development_dependency(%q<thin>, [">= 1.0.0"])
      s.add_development_dependency(%q<rack>, [">= 0.9.1"])
    else
      s.add_dependency(%q<mechanize>, [">= 0.9.0"])
      s.add_dependency(%q<ick>, [">= 0.3.0"])
      s.add_dependency(%q<pingfm>, [">= 1.0.1"])
      s.add_dependency(%q<bones>, [">= 2.4.0"])
      s.add_dependency(%q<open4>, [">= 0.9.6"])
      s.add_dependency(%q<thin>, [">= 1.0.0"])
      s.add_dependency(%q<rack>, [">= 0.9.1"])
    end
  else
    s.add_dependency(%q<mechanize>, [">= 0.9.0"])
    s.add_dependency(%q<ick>, [">= 0.3.0"])
    s.add_dependency(%q<pingfm>, [">= 1.0.1"])
    s.add_dependency(%q<bones>, [">= 2.4.0"])
    s.add_dependency(%q<open4>, [">= 0.9.6"])
    s.add_dependency(%q<thin>, [">= 1.0.0"])
    s.add_dependency(%q<rack>, [">= 0.9.1"])
  end
end
