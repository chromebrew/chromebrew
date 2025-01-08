require 'buildsystems/ruby'

class Ruby_pathname < RUBY
  description 'Representation of the name of a file or directory on the filesystem.'
  homepage 'https://github.com/ruby/pathname'
  version "0.4.0-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: 'dbfe41b7683b7c3efc0710be58460e3ac2de0a66a03ffa225c39ec1283b132eb',
     armv7l: 'dbfe41b7683b7c3efc0710be58460e3ac2de0a66a03ffa225c39ec1283b132eb',
       i686: '80df189ff31aa90245c1dcca3334c508ca9f5d3927dfd5c75a42986fb6a30510',
     x86_64: 'ee8391154644f784ad6973affb92af5bf70a5cba0317f9383784c38b71fa275c'
  })

  conflicts_ok
  gem_compile_needed
end
