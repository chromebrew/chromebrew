require 'buildsystems/ruby'

class Ruby_prism < RUBY
  description 'Prism is a parser for the Ruby programming language.'
  homepage 'https://github.com/ruby/prism'
  version "1.7.0-#{CREW_RUBY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '0d4821c5608717cac99b9c3d64e04543c46fa166bf5b154f461b383d497172d0',
     armv7l: '0d4821c5608717cac99b9c3d64e04543c46fa166bf5b154f461b383d497172d0',
       i686: 'b630577e5328fdb734f87b4a7fed2dcfce1c68311b0877db934301ccdd53bd6b',
     x86_64: 'dae3fe75b6e12f2c357cbdcd58a28e43c970e43ce1b324b4837ff5a9b85b8dc8'
  })

  conflicts_ok
  gem_compile_needed
end
