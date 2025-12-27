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
    aarch64: 'dce6f8f583be42db4e0fc13ff916af39a27788739c78c92fd626e218127e53d2',
     armv7l: 'dce6f8f583be42db4e0fc13ff916af39a27788739c78c92fd626e218127e53d2',
       i686: '5fb4646f2f3c9e86391b9aee1a3e01877477e9cac2361d2a90bd48cca1b17775',
     x86_64: 'c124e7e0fde8831456c59101263283bd9cb3a3e8b3451d4f96bbcd413c45b700'
  })

  depends_on 'glibc' # R
  depends_on 'ruby' # R

  conflicts_ok
  gem_compile_needed
end
