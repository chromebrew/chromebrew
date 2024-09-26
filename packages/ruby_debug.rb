require 'buildsystems/ruby'

class Ruby_debug < RUBY
  description 'The debug library provides debugging functionality to Ruby (MRI) 2.7 and later.'
  homepage 'https://github.com/ruby/debug'
  version "1.9.2-#{CREW_RUBY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '6b7344390da0b795d379c4e95ce41242a6392324a9c1f5e27bbba9a4b01a792a',
     armv7l: '6b7344390da0b795d379c4e95ce41242a6392324a9c1f5e27bbba9a4b01a792a',
       i686: '149ddb718f60aba21ca7aa3370df2e650d2b316117285b29c7de158da91711f7',
     x86_64: 'ec3e4a33ea6dd305c666c641e510b891816483116313e7c35d683b2dbcabd035'
  })

  conflicts_ok
  gem_compile_needed
  no_source_build
end
