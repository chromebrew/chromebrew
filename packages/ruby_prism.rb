require 'buildsystems/ruby'

class Ruby_prism < RUBY
  description 'Prism is a parser for the Ruby programming language.'
  homepage 'https://github.com/ruby/prism'
  version "1.5.1-#{CREW_RUBY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '8f398259134d34bc42ed82a689ce311f6aa80bcb5329a3fe57a57058832efadf',
     armv7l: '8f398259134d34bc42ed82a689ce311f6aa80bcb5329a3fe57a57058832efadf',
       i686: 'b68a93e2c3c47c249add17db2739203bb4fa60b725e0c2e81e2863468b5728b6',
     x86_64: '8e77ab62186285781f213fe6a5e58b6f50fdd48a5251b212853c7864af28674e'
  })

  conflicts_ok
  gem_compile_needed
end
