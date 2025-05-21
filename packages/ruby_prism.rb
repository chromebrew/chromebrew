require 'buildsystems/ruby'

class Ruby_prism < RUBY
  description 'Prism is a parser for the Ruby programming language.'
  homepage 'https://github.com/ruby/prism'
  version "1.4.0-#{CREW_RUBY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '123fb1451c9792ff1a5ecbedfbe0b8619317773a9b71711c4d43298700dea6c4',
     armv7l: '123fb1451c9792ff1a5ecbedfbe0b8619317773a9b71711c4d43298700dea6c4',
       i686: 'daa1992912dd9414d7e98d4e7377cbeca6d02c412ec252df79f9a18852b3c724',
     x86_64: 'd6aafc394011abef72953aaf932714f905400dcd23e7ad69a5a38375b4f8ba54'
  })

  conflicts_ok
  gem_compile_needed
end
