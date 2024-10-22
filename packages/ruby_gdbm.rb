require 'buildsystems/ruby'

class Ruby_gdbm < RUBY
  description 'Ruby extension for GNU dbm.'
  homepage 'https://github.com/ruby/gdbm'
  version "2.1.0-#{CREW_RUBY_VER}"
  license 'BSD-2-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '189ed64b1386a53ca1947d42d768cffc1967ac4ec0f9c7a1969c00808bd5be80',
     armv7l: '189ed64b1386a53ca1947d42d768cffc1967ac4ec0f9c7a1969c00808bd5be80',
       i686: 'e67e801843fe384f64494901707580e31dd18d3ff1fd6fecd4bc72c1d57ea42a',
     x86_64: 'c1697765011754fc803a457b9a3dc284dffbb7e743e79ab793dd1c0b8ea36714'
  })

  conflicts_ok
  gem_compile_needed
end
