require 'buildsystems/ruby'

class Ruby_digest < RUBY
  description 'Provides a framework for message digest libraries.'
  homepage 'https://github.com/ruby/digest'
  version "3.3.0-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '0e790a4e1a4100fa0ec4ac7cb84f36b042bd18d4d1489ff1103d01745d87a12d',
     armv7l: '0e790a4e1a4100fa0ec4ac7cb84f36b042bd18d4d1489ff1103d01745d87a12d',
       i686: '96a1e16d002c3d67881cb46420e9000a940e9a6d215d2eef8c2dc659c32b444b',
     x86_64: 'e50da7e4d1792b3790228e647a107f74d6458564838ff50051473e17d8c533bb'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'ruby' => :library

  conflicts_ok
  gem_compile_needed
end
