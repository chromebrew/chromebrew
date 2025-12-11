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
    aarch64: 'eb40431e74c99abd3113db3bc6c9764e377fbccde70d423ed82bbb2651794ee4',
     armv7l: 'eb40431e74c99abd3113db3bc6c9764e377fbccde70d423ed82bbb2651794ee4',
       i686: '3dbb576d37ab881406f6deb81e5e57a317c149401f0ed05b460168963f204c17',
     x86_64: '6cccb22349171aa514fe6e6b14b5336b29f58b47ce62b3714497d6530d26900a'
  })

  depends_on 'glibc' # R
  depends_on 'ruby' # R

  conflicts_ok
  gem_compile_needed
end
