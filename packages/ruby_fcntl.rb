require 'buildsystems/ruby'

class Ruby_fcntl < RUBY
  description 'Loads constants defined in the os fcntl.'
  homepage 'https://github.com/ruby/fcntl'
  version "1.3.0-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '656d15449c41be93bb79ea6f889306d1fbafb13db68134d951d62b91d4f58be5',
     armv7l: '656d15449c41be93bb79ea6f889306d1fbafb13db68134d951d62b91d4f58be5',
       i686: '280dac9a4e4eb50656fdc845d81a92be8a1f2474b472b004588b9e231fdabae2',
     x86_64: 'dc59456c573d998df6f53363648b34cbee700dca440d80d6a9d97c13aaca76f9'
  })

  conflicts_ok
  gem_compile_needed
end
