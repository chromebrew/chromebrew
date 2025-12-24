require 'buildsystems/ruby'

class Ruby_rbs < RUBY
  description 'RBS is the language for type signatures for Ruby and standard library definitions.'
  homepage 'https://github.com/ruby/rbs'
  version "3.10.0-#{CREW_RUBY_VER}"
  license 'BSD-2-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '73925cb75ad9b7f95c585da28d6f81a543688d38353cf1c298101eee977e9f0a',
     armv7l: '73925cb75ad9b7f95c585da28d6f81a543688d38353cf1c298101eee977e9f0a',
       i686: '7443c5d871dc6ca461ff1b45fa51d1407702c4d4e88e02446f2223dba0bd1b02',
     x86_64: 'cc64938415df71a9f57e3ed2a635ef195da47657f19afa8af284cc5ea484c323'
  })

  depends_on 'glibc' # R
  depends_on 'ruby' # R
  depends_on 'ruby_abbrev' # R
  depends_on 'ruby_logger' # R

  conflicts_ok
  gem_compile_needed
  no_source_build
end
