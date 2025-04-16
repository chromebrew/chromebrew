require 'buildsystems/ruby'

class Ruby_rubygems_update < RUBY
  description 'RubyGems is a package management framework for Ruby.'
  homepage 'https://github.com/rubygems/rubygems'
  version "3.6.8-#{CREW_RUBY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'

  conflicts_ok
  no_compile_needed

  def postinstall
    system 'gem update -N --system'
  end
end
