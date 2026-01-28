require 'buildsystems/ruby'

class Ruby_prism < RUBY
  description 'Prism is a parser for the Ruby programming language.'
  homepage 'https://github.com/ruby/prism'
  version "1.9.0-#{CREW_RUBY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '125cec1a97e43b9b97ae6b22ab0f3748d52b3c737d75d02c6f2d9e5e220aab9b',
     armv7l: '125cec1a97e43b9b97ae6b22ab0f3748d52b3c737d75d02c6f2d9e5e220aab9b',
       i686: '960cc32aa112881e0e106a21710941e1e302378e6396e76765c510cb061a6b8e',
     x86_64: '51eb192bac7f183f41f4fd13d693978f7c9da50c38f1694940c081f0ad55a710'
  })

  depends_on 'glibc' # R
  depends_on 'ruby' # R

  conflicts_ok
  gem_compile_needed
end
