require 'buildsystems/ruby'

class Ruby_rbs < RUBY
  description 'RBS is the language for type signatures for Ruby and standard library definitions.'
  homepage 'https://github.com/ruby/rbs'
  version "3.10.3-#{CREW_RUBY_VER}"
  license 'BSD-2-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: 'cab81499585b3f3454e9370104ba1388cc4e9f91c4728573341dee77335a4767',
     armv7l: 'cab81499585b3f3454e9370104ba1388cc4e9f91c4728573341dee77335a4767',
       i686: 'ec0d326029dbc9cb9d1ed8fcd6c45d62f77c9a7b77d491f4fb45ac854bd2dc86',
     x86_64: 'aaade95cfb4b0141d313dfba766e193324474cfe1c279583da1812d1fdf106bf'
  })

  depends_on 'glibc' # R
  depends_on 'ruby' # R
  depends_on 'ruby_abbrev' # R
  depends_on 'ruby_logger' # R

  conflicts_ok
  gem_compile_needed
  no_source_build
end
