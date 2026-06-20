require 'buildsystems/ruby'

class Ruby_rbs < RUBY
  description 'RBS is the language for type signatures for Ruby and standard library definitions.'
  homepage 'https://github.com/ruby/rbs'
  version "4.0.3-#{CREW_RUBY_VER}"
  license 'BSD-2-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: 'fd714fc2536ffab10908b5a097498b70b4451a3f54178b32e5767b6b068aae3b',
     armv7l: 'fd714fc2536ffab10908b5a097498b70b4451a3f54178b32e5767b6b068aae3b',
       i686: '3419157cf4546c05fc43c18afeb89dcc33239f6603ba79c55862b768625a0b26',
     x86_64: '76781909386970bdbd4b52a21850e850f811e7717d5dc1e9ca26eab30ee0bc7d'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'ruby' => :library
  depends_on 'ruby_logger' # R
  depends_on 'ruby_tsort' # R

  conflicts_ok
  gem_compile_needed
  no_source_build
end
