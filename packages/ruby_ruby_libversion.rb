require 'buildsystems/ruby'

class Ruby_ruby_libversion < RUBY
  description 'Ruby bindings for libversion.'
  homepage 'https://github.com/Zopolis4/ruby-libversion'
  version "1.0.0-2-#{CREW_RUBY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: 'b82794a10b04fa6041bdf836a300527704b87db1cbf167a545f38456899e1dcf',
     armv7l: 'b82794a10b04fa6041bdf836a300527704b87db1cbf167a545f38456899e1dcf',
       i686: '2b2dadb3a8d2a0289bd40558fd5d3ef8b25e31157eb9a02558369c9e47b1783b',
     x86_64: 'ab7b4acda26268bca9fd13a88db52113ac7b99a4e906f26f41fda5f72b2beb58'
  })

  depends_on 'libversion' # R
  gem_compile_needed
end
