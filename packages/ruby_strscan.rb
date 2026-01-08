require 'buildsystems/ruby'

class Ruby_strscan < RUBY
  description 'Provides lexical scanning operations on a String.'
  homepage 'https://github.com/ruby/strscan'
  version "3.1.7-#{CREW_RUBY_VER}"
  license 'BSD-2-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '8a3488be3d51ff41313af5c8cbf6b07f40d5ed0d9687e97c02a20793094111df',
     armv7l: '8a3488be3d51ff41313af5c8cbf6b07f40d5ed0d9687e97c02a20793094111df',
       i686: '21af62648d10b861ea508739bad4e6551bad836005d0ee96a2926fba207fce29',
     x86_64: '7dde2914d650c0e39e28a7c5a2bfc1fb584e47fee7bd5205945482d8e9f73fc4'
  })

  depends_on 'glibc' # R
  depends_on 'ruby' # R

  conflicts_ok
  gem_compile_needed
  no_source_build
end
