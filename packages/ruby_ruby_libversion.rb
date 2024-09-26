require 'buildsystems/ruby'

class Ruby_ruby_libversion < RUBY
  description 'Ruby bindings for libversion.'
  homepage 'https://github.com/Zopolis4/ruby-libversion'
  version "1.0.0-1-#{CREW_RUBY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '694e8851a3a5f683fe2b13d3021857d13377a666681db13f9921d704fb23eead',
     armv7l: '694e8851a3a5f683fe2b13d3021857d13377a666681db13f9921d704fb23eead',
       i686: 'e811dc6dbf8237b43736535722d29c0a1241ce6cf6d5120a61d412d569194986',
     x86_64: 'f52ded350de72587350361049a671e19a9d387e41ceac582a83b3d7bb50db234'
  })

  depends_on 'libversion' # R
  gem_compile_needed
  no_source_build
end
