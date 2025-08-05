require 'buildsystems/ruby'

class Ruby_io_console < RUBY
  description 'add console capabilities to IO instances.'
  homepage 'https://github.com/ruby/io-console'
  version "0.8.1-#{CREW_RUBY_VER}"
  license 'BSD-2-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '6dd328b99a72d54a5bc932f71844881541a3a13f52c64e37c18547901ca24c3d',
     armv7l: '6dd328b99a72d54a5bc932f71844881541a3a13f52c64e37c18547901ca24c3d',
       i686: 'c117feb1dccfc6f5ecefea5a93ffed89f50351bff70a0953aee0b88e73f610eb',
     x86_64: 'a6d663b33e4e55483dd0cad9ab16798a66a734b6d580c9a9ea2ede3ad6cc71e7'
  })

  conflicts_ok
  gem_compile_needed
end
