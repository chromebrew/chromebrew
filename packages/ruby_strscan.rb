require 'buildsystems/ruby'

class Ruby_strscan < RUBY
  description 'Provides lexical scanning operations on a String.'
  homepage 'https://github.com/ruby/strscan'
  version "3.1.0-#{CREW_RUBY_VER}"
  license 'BSD-2-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '51c1cbbac26cd4625d999e2c074807e057e9a504a8f2e274178db047cef2b15c',
     armv7l: '51c1cbbac26cd4625d999e2c074807e057e9a504a8f2e274178db047cef2b15c',
       i686: 'a79e1f744507fbb733381a41afe31a43a6faed87286548cb778b499a464dca20',
     x86_64: '1153ee8ee70684e1b78ca6fe1fef313ef256079fe468a3a5a556de2f2659ef52'
  })

  conflicts_ok
  gem_compile_needed
  no_source_build
end
