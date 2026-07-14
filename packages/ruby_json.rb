require 'buildsystems/ruby'

class Ruby_json < RUBY
  description 'This is a JSON implementation as a Ruby extension in C.'
  homepage 'https://flori.github.io/json'
  version "2.21.1-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: 'e8440ef259763f811c7781a1d752cb842a628d433bdd89100120e69dc5ccee77',
     armv7l: 'e8440ef259763f811c7781a1d752cb842a628d433bdd89100120e69dc5ccee77',
       i686: 'd257ce5590a66d0abb5ef2d360e2aebf374af23883d95df3078fc46341455f42',
     x86_64: '4cc2ec682ce6e3205bfabd5fec49bf163de358ae1602b0b0e34c1b925fa31f9e'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'ruby' => :library

  conflicts_ok
  gem_compile_needed
end
