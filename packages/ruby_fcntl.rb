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
     x86_64: '5d7e8d0d5620baf40e0c091099b8aa5e1c9e37058efcfdeabb43876b545d2c05'
  })

  conflicts_ok
  gem_compile_needed
end
