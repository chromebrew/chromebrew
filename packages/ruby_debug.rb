require 'buildsystems/ruby'

class Ruby_debug < RUBY
  description 'The debug library provides debugging functionality to Ruby (MRI) 2.7 and later.'
  homepage 'https://github.com/ruby/debug'
  version "1.10.0-#{CREW_RUBY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: 'a2e20733b547ec3c4213bd402ef4a33eedbfed7da7c0f0e423bb31b76963e8ff',
     armv7l: 'a2e20733b547ec3c4213bd402ef4a33eedbfed7da7c0f0e423bb31b76963e8ff',
       i686: 'c8053721a5c8875f4a36ed66f7aa067f175de923e60ad43ed120cee991c74039',
     x86_64: 'c0a9aa18722f3afd924eb9ddcc6595e2efd22752c76f19a462334b2ee1988057'
  })

  depends_on 'ruby_reline' # R

  depends_on 'ruby_irb' # R

  conflicts_ok
  gem_compile_needed
  no_source_build
end
