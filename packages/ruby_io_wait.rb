require 'buildsystems/ruby'

class Ruby_io_wait < RUBY
  description 'Waits until io is readable or writable without blocking.'
  homepage 'https://github.com/ruby/io-wait'
  version "0.3.5-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: 'ebcf53adb9d7854f2e18bf75c247e75c5682e356b5d2afc0153de666f1e0610f',
     armv7l: 'ebcf53adb9d7854f2e18bf75c247e75c5682e356b5d2afc0153de666f1e0610f',
       i686: 'd9c5245f60b95276be14ec7870d13feaf0fa392a64e4b095e626482cf16cc7ce',
     x86_64: 'df280a9c34a71a7407f51acfdc2bf191c62d7b95ab5a2eae9e40c8642b5fee3c'
  })

  conflicts_ok
  gem_compile_needed
end
