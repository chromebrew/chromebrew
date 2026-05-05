require 'buildsystems/ruby'

class Ruby_json < RUBY
  description 'This is a JSON implementation as a Ruby extension in C.'
  homepage 'https://flori.github.io/json'
  version "2.19.5-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: 'ff9aea59c92ef13ca28516db4e0c386e1378daf98d0f68cc6a2cc4646a364191',
     armv7l: 'ff9aea59c92ef13ca28516db4e0c386e1378daf98d0f68cc6a2cc4646a364191',
       i686: 'cd1ac79cbbbd81a11170f23d13985472dbc578263085ae1c2c448b7a47aca0ca',
     x86_64: '861a8aa4c6f536f2f6d295cc4be00bd9f4ca9b1940f0af559810dc74f6c100c1'
  })

  depends_on 'glibc' => :library
  depends_on 'ruby' => :library

  conflicts_ok
  gem_compile_needed
end
