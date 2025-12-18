require 'buildsystems/ruby'

class Ruby_io_wait < RUBY
  description 'Waits until io is readable or writable without blocking.'
  homepage 'https://github.com/ruby/io-wait'
  version "0.4.0-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '1e550073d072d5dc82dbe52d46b9618785784079abc10fc94412d184a33c23a4',
     armv7l: '1e550073d072d5dc82dbe52d46b9618785784079abc10fc94412d184a33c23a4',
       i686: 'bc2b439f9453a0fc984c254167028fcfa9a64471f065f72b59b645e4c00b1514',
     x86_64: '815ae8bd8961c457da7734da2a5cdc2ed5d3d5deeb8ad746e6cfac9587c67c97'
  })

  conflicts_ok
  gem_compile_needed
end
