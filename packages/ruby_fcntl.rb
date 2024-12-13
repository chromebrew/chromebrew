require 'buildsystems/ruby'

class Ruby_fcntl < RUBY
  description 'Loads constants defined in the os fcntl.'
  homepage 'https://github.com/ruby/fcntl'
  version "1.2.0-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '5c70a361da3cedbac596ce40bfe1807a0a5a263cedeb290aa7db99abe65793f8',
     armv7l: '5c70a361da3cedbac596ce40bfe1807a0a5a263cedeb290aa7db99abe65793f8',
       i686: '1af766faa607737239f2e96a9991e56610ae9e666e9f848627061922276a1b84',
     x86_64: '5d7e8d0d5620baf40e0c091099b8aa5e1c9e37058efcfdeabb43876b545d2c05'
  })

  conflicts_ok
  gem_compile_needed
end
