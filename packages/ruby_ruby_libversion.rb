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
    aarch64: 'ec87b38fb09bdff6bf2f5b89c4f4eb275078407234fe7e4bdcad0eef676edab6',
     armv7l: 'ec87b38fb09bdff6bf2f5b89c4f4eb275078407234fe7e4bdcad0eef676edab6',
       i686: 'd1ff6e76b3ab134b5a1cc3fc0fdb314930f7aa3b87eb4e0eb1e846d75cd19069',
     x86_64: '513694e8aaa844a72bcf2c9dcbd75ea3f0b23d743d583c5b2028a6809b811362'
  })

  depends_on 'libversion' # R
  gem_compile_needed
end
