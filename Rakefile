# Look in the tasks/setup.rb file for the various options that can be
# configured in this Rakefile. The .rake files in the tasks directory
# are where the options are used.

load 'tasks/setup.rb'

ensure_in_path 'lib'
require 'preen'

task :default => 'spec:run'

PROJ.name = 'preen'
PROJ.authors = 'Avdi Grimm'
PROJ.email = 'avdi@avdi.org'
PROJ.url = 'http://github.com/avdi/preen'
PROJ.version = Preen::VERSION
PROJ.rubyforge.name = 'preen'
PROJ.readme_file = 'README.rdoc'

PROJ.exclude << 'tmp$'

# Dependencies

depend_on 'mechanize', '>= 0.9.0'
depend_on 'ick',       '>= 0.3.0'
depend_on 'pingfm',    '>= 1.0.1'
depend_on 'main',      '>= 2.8.3'

dev_depend_on 'open4', '>= 0.9.6'
dev_depend_on 'thin',  '>= 1.0.0'
dev_depend_on 'rack',  '>= 0.9.1'

# Uncomment to disable warnings
PROJ.ruby_opts = []

# RSpec
PROJ.spec.opts << '--color -fs'

# RDoc
PROJ.rdoc.include << '\.rdoc$'

# Email Announcement
PROJ.ann.email[:from]     = 'avdi@avdi.org'
PROJ.ann.email[:to]       = 'ruby-talk@ruby-lang.org'
PROJ.ann.email[:server]   = 'smtp.gmail.com'
PROJ.ann.email[:domain]   = 'avdi.org'
PROJ.ann.email[:port]     = 587
PROJ.ann.email[:acct]     = 'avdi.grimm'
PROJ.ann.email[:authtype] = :plain

# Notes
PROJ.notes.extensions << '.rdoc'

# EOF
