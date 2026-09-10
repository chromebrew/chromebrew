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
    aarch64: '5fc4ff84582bcc2f1d3fa186e97ed49a2c21855c8a55c85b3ffc98bf2211b80b',
     armv7l: '5fc4ff84582bcc2f1d3fa186e97ed49a2c21855c8a55c85b3ffc98bf2211b80b',
       i686: '7cf2109c99087e7645d836b916dcb9815e6d57d498b1dcaf3d66f0e6dddb271b',
     x86_64: '91716e845d00a725255188f6d7564248daa9068bede40053858c7d214bf44e96'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'ruby' => :library

  conflicts_ok
  gem_compile_needed
end
