require 'buildsystems/ruby'

class Ruby_rubygems_update < RUBY
  description 'RubyGems is a package management framework for Ruby.'
  homepage 'https://guides.rubygems.org'
  version "3.5.20-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'

  conflicts_ok
  no_compile_needed
end
