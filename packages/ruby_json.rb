require 'buildsystems/ruby'

class Ruby_json < RUBY
  description 'This is a JSON implementation as a Ruby extension in C.'
  homepage 'https://flori.github.io/json'
  version "3.0.2-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: 'f47434c504a5045e14c782629c2cae2feab8d747c736ffe2ff42bdacc3805b29',
     armv7l: 'f47434c504a5045e14c782629c2cae2feab8d747c736ffe2ff42bdacc3805b29',
       i686: 'e7797fdc1225cac8d9724fedb0ae004c8179888201f8d7748739bb84dfc95c9f',
     x86_64: '434b79d1586b242c240140602ac031f5e7f90b662e54d5b4f87998a885f230db'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'ruby' => :library

  conflicts_ok
  gem_compile_needed
end
