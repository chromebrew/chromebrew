require 'buildsystems/ruby'

class Ruby_fiddle < RUBY
  description 'A libffi wrapper for ruby.'
  homepage 'https://github.com/ruby/fiddle'
  version "1.1.8-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '6c9742b3101b5f8222c3a27d969f92caa8d4875c4d77feb99051cb71dcbe3a44',
     armv7l: '6c9742b3101b5f8222c3a27d969f92caa8d4875c4d77feb99051cb71dcbe3a44',
       i686: '60ea5261f339048e9393cc1d8fac09c92303a55a3b0ef238482148a8e3e27b54',
     x86_64: '0b9ee21db9d0d88443923337300e49609761e9aa9424d1098a2ebfc601faee9f'
  })

  conflicts_ok
  gem_compile_needed
end
