require 'buildsystems/ruby'

class Ruby_fiddle < RUBY
  description 'A libffi wrapper for ruby.'
  homepage 'https://github.com/ruby/fiddle'
  version "1.1.5-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: 'ae51eed09acce2e7226f885ced440678e4504e967ddbeaa3818e94735649da6b',
     armv7l: 'ae51eed09acce2e7226f885ced440678e4504e967ddbeaa3818e94735649da6b',
       i686: '7d0c7b9dafe2392420dbc236a7efd7ae6b3ed28812165dc43562c10e5d782709',
     x86_64: '691e45fedbfbc0d59c5fe0a0e2d7eae4f38ccdfc0a4cc1c0feeff25f359d500e'
  })

  conflicts_ok
  gem_compile_needed
end
