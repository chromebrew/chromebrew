require 'buildsystems/ruby'

class Ruby_cgi < RUBY
  description 'Support for the common gateway interface protocol.'
  homepage 'https://github.com/ruby/cgi'
  version "0.5.1-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '9a8e934fb192f32542a87df91baaa03086ddd14ee8dbb7e775606f4c6c20f781',
     armv7l: '9a8e934fb192f32542a87df91baaa03086ddd14ee8dbb7e775606f4c6c20f781',
       i686: '800fbfbe1e6ec939de9d9aa8fe791a73fca655edb4b20458d8cdd7cb55aa3d23',
     x86_64: '4c0e2ff6099091acd23f8b5e4e3789e778a8ca9da68c9800b142971c54feb84c'
  })

  depends_on 'glibc' # R
  depends_on 'ruby' # R

  conflicts_ok
  gem_compile_needed
end
