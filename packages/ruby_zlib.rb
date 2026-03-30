require 'buildsystems/ruby'

class Ruby_zlib < RUBY
  description 'Ruby interface for the zlib compression/decompression library.'
  homepage 'https://github.com/ruby/zlib'
  version "3.2.3-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '23ad3d6232f93996555e1f9abec3db8b7d71d6f67449ae33b1c9e5de049ed993',
     armv7l: '23ad3d6232f93996555e1f9abec3db8b7d71d6f67449ae33b1c9e5de049ed993',
       i686: 'ee8ff3241df674a136c39909504b4089b6dda06785596a337152ccbe6bb2a6b3',
     x86_64: 'c7c1525600542fb0e2f266cb0cd6e35dd599eeb6fccfd56dd41888243b242414'
  })

  depends_on 'glibc' => :library
  depends_on 'ruby' => :library
  depends_on 'zlib' => :library

  conflicts_ok
  gem_compile_needed
end
