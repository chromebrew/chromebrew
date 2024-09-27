require 'buildsystems/ruby'

class Ruby_fiddle < RUBY
  description 'A libffi wrapper for ruby.'
  homepage 'https://github.com/ruby/fiddle'
  version "1.1.2-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
     x86_64: '6aa32335992948369b986fdb700089a37beda2e441b0371712cf1b5245716d14'
  })

  conflicts_ok
  gem_compile_needed
end
