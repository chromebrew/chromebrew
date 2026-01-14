require 'buildsystems/ruby'

class Ruby_ruby_libversion < RUBY
  description 'Ruby bindings for libversion.'
  homepage 'https://github.com/Zopolis4/ruby-libversion'
  version "1.1.0-#{CREW_RUBY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '2baec6707875534dd46e07bd6af63c2f468817e46d8370d541aa8320ce50aaf1',
     armv7l: '2baec6707875534dd46e07bd6af63c2f468817e46d8370d541aa8320ce50aaf1',
       i686: 'f52bb843a0bc6cd11d577fba210086650f3c80767dd7c7b4d1ff8907409f6e53',
     x86_64: '0d6e1186a3f70fb1ff561939d718aef9c29415751c29771a0a7f40fbc7ab898a'
  })

  depends_on 'glibc' # R
  depends_on 'libversion' # R
  depends_on 'ruby' # R
  gem_compile_needed
end
