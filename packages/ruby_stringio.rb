require 'buildsystems/ruby'

class Ruby_stringio < RUBY
  description 'Pseudo `io` class from/to `string`.'
  homepage 'https://github.com/ruby/stringio'
  version "3.1.8-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: 'bf5de15de4a6151e6de500b6adb40aaf1da9d0635b4911d6f0a753be219ea3f0',
     armv7l: 'bf5de15de4a6151e6de500b6adb40aaf1da9d0635b4911d6f0a753be219ea3f0',
       i686: '1fe2d2ca7377cecfeecb9a2341f7782afa42f34399ca8180bf011c8bb296bd0d',
     x86_64: '20443fa4856e423f3ad3f764c2f75ab4fb3f6b36d6ef2fdd9840faa83500d0bd'
  })

  conflicts_ok
  gem_compile_needed
end
