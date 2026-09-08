require 'buildsystems/ruby'

class Ruby_json < RUBY
  description 'This is a JSON implementation as a Ruby extension in C.'
  homepage 'https://flori.github.io/json'
  version "3.0.0-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: 'a503536c9a2956c99ab4b3a2ac78c8825b75b5e269da797707fa46e358529d2d',
     armv7l: 'a503536c9a2956c99ab4b3a2ac78c8825b75b5e269da797707fa46e358529d2d',
       i686: '7edc3864a2135bfd8e6a0680e42ce5d3907b58a64d27e599b2d92856d9ff7589',
     x86_64: '7529d61b7cc6a89f5a79fbf08e18e2de8a4e576a948e6855c4ef6d2ae2ea449f'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'ruby' => :library

  conflicts_ok
  gem_compile_needed
end
