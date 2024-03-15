require 'buildsystems/ruby'

class Ruby_activesupport < RUBY
  description 'A toolkit of support libraries and Ruby core extensions extracted from the Rails framework.'
  homepage 'https://rubyonrails.org/'
  version '7.1.3.2'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'

  conflicts_ok
  no_compile_needed
end
