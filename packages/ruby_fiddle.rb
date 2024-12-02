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
       i686: 'f0d72080c63dd659e383f3d6424e3bd8698627603fc66b898d7961f7fa4e8bc4',
     x86_64: '691e45fedbfbc0d59c5fe0a0e2d7eae4f38ccdfc0a4cc1c0feeff25f359d500e'
  })

  conflicts_ok
  gem_compile_needed
end
