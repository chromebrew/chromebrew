require 'buildsystems/ruby'

class Ruby_json < RUBY
  description 'This is a JSON implementation as a Ruby extension in C.'
  homepage 'https://flori.github.io/json'
  version "2.18.1-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: 'b18bfd549cb6d6c1e19f74d3e6dc671b4793e657c8964bba933f0af4a7b164c5',
     armv7l: 'b18bfd549cb6d6c1e19f74d3e6dc671b4793e657c8964bba933f0af4a7b164c5',
       i686: 'e63bd349f72c2294c5bbedf18fa78412ead6ad10dd15c9845f35dc7143684851',
     x86_64: 'b02a8e5d849bd97bb9a13e6f2d7a9c9d69606ad71689550f6769d74cdab9fb8c'
  })

  depends_on 'glibc' # R
  depends_on 'ruby' # R

  conflicts_ok
  gem_compile_needed
end
