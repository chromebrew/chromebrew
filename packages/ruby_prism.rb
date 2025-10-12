require 'buildsystems/ruby'

class Ruby_prism < RUBY
  description 'Prism is a parser for the Ruby programming language.'
  homepage 'https://github.com/ruby/prism'
  version "1.5.2-#{CREW_RUBY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: 'f439b5d94d2726cb24b7da098fc9bdedfb336af8cb1a09572e3b6b400b7ae141',
     armv7l: 'f439b5d94d2726cb24b7da098fc9bdedfb336af8cb1a09572e3b6b400b7ae141',
       i686: '92feafeedf6c8b5287bc8aa883e68b7b7d249986dead09f847bc08f15b5d976f',
     x86_64: '60bcfc33089d3a9edaf92312e9464a4719398699fc42cdaa99bcbf8bd935e416'
  })

  conflicts_ok
  gem_compile_needed
end
