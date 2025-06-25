require 'buildsystems/ruby'

class Ruby_debug < RUBY
  description 'The debug library provides debugging functionality to Ruby (MRI) 2.7 and later.'
  homepage 'https://github.com/ruby/debug'
  version "1.11.0-#{CREW_RUBY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: 'a2e20733b547ec3c4213bd402ef4a33eedbfed7da7c0f0e423bb31b76963e8ff',
     armv7l: 'a2e20733b547ec3c4213bd402ef4a33eedbfed7da7c0f0e423bb31b76963e8ff',
       i686: 'ccf6c9a901804bcc1618a5e8a69c34f68c024fc9f5dd3fcbe9864035d30d4d3f',
     x86_64: 'c0a9aa18722f3afd924eb9ddcc6595e2efd22752c76f19a462334b2ee1988057'
  })

  depends_on 'ruby_reline' # R

  depends_on 'ruby_irb' # R

  conflicts_ok
  gem_compile_needed
  no_source_build
end
