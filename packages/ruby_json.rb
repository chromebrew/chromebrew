require 'buildsystems/ruby'

class Ruby_json < RUBY
  description 'This is a JSON implementation as a Ruby extension in C.'
  homepage 'https://flori.github.io/json'
  version "2.19.4-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '7efefc62a9e5b421505a9ddafea454940e9da08a3910cc0b9f2e8d35f73a99fe',
     armv7l: '7efefc62a9e5b421505a9ddafea454940e9da08a3910cc0b9f2e8d35f73a99fe',
       i686: '2e8ff6225ca7b5bca0d65e9ae298d3b2f805a176ba09b419a1163584ab6dd0df',
     x86_64: '685aaea251292cf2d8e33ba54478349892f364aac58705fbc6c0ad9f0a10e4df'
  })

  depends_on 'glibc' => :library
  depends_on 'ruby' => :library

  conflicts_ok
  gem_compile_needed
end
