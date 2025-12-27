require 'buildsystems/ruby'

class Ruby_etc < RUBY
  description 'Provides access to information typically stored in unix /etc directory.'
  homepage 'https://github.com/ruby/etc'
  version "1.4.6-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '902b01e15695b16dae12ae1fbf29fdcdd0650d94c566fcf44bc6ad9c01cf308b',
     armv7l: '902b01e15695b16dae12ae1fbf29fdcdd0650d94c566fcf44bc6ad9c01cf308b',
       i686: '928504ff80bd692a8052f7824dff2e50d29437a0cd026418eeaa942970e6cf02',
     x86_64: 'c9e608243f39c6c1fc45c81f0b61ae8e8d2181e2d2cb6595fde44762524fa5af'
  })

  depends_on 'glibc' # R
  depends_on 'ruby' # R

  conflicts_ok
  gem_compile_needed
end
