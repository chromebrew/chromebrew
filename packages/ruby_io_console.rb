require 'buildsystems/ruby'

class Ruby_io_console < RUBY
  description 'add console capabilities to IO instances.'
  homepage 'https://github.com/ruby/io-console'
  version "0.7.2-#{CREW_RUBY_VER}"
  license 'BSD-2-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '06f4f3a330dc32702312c8e780befe38a806952fa5b9696d5312f4ff90a25ab5',
     armv7l: '06f4f3a330dc32702312c8e780befe38a806952fa5b9696d5312f4ff90a25ab5',
       i686: '6f40b9e68df8b61181ef3d5ca2cf98e93686dc29f3d3f276b75946f11f8e3644',
     x86_64: 'a83756be0c64cd9c86b679e71e9f29e7d4f82bd0f330c663d1b44ae0c1ce76ce'
  })

  conflicts_ok
  gem_compile_needed
end
