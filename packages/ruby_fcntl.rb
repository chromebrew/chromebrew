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
    aarch64: 'd12c37dd64e2036ace6a1d821945cbe1f37e286f95d6c76acddd48c50910f06c',
     armv7l: 'd12c37dd64e2036ace6a1d821945cbe1f37e286f95d6c76acddd48c50910f06c',
       i686: '4c750bb1529ee671825c9ac0c005293736cf4b773b953281066a86bc156873a4',
     x86_64: '6d1b4297d4637b6c7a0f6ca7d5f078a6fd4475e184f71417f0f71d84ea7b8559'
  })

  conflicts_ok
  gem_compile_needed
end
