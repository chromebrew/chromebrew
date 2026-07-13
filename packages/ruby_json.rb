require 'buildsystems/ruby'

class Ruby_json < RUBY
  description 'This is a JSON implementation as a Ruby extension in C.'
  homepage 'https://flori.github.io/json'
  version "2.21.0-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: 'e755b0af4c4cdb515f3e6375ad69c00910f2f9be69e6ad8f0d8d6165661b1dab',
     armv7l: 'e755b0af4c4cdb515f3e6375ad69c00910f2f9be69e6ad8f0d8d6165661b1dab',
       i686: '01b7741ae602ac0ab2e151bbc0a872b0d10d15349feae8b6acc7fdbc42144849',
     x86_64: '05057e6d8456be1fae739bc2b204ba67b3bacefc411e90b3060c025b43b81769'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'ruby' => :library

  conflicts_ok
  gem_compile_needed
end
