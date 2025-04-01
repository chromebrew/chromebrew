require 'buildsystems/ruby'

class Ruby_rbs < RUBY
  description 'RBS is the language for type signatures for Ruby and standard library definitions.'
  homepage 'https://github.com/ruby/rbs'
  version "3.9.2-#{CREW_RUBY_VER}"
  license 'BSD-2-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: 'f92e7452ca9c62a1605122430c4e184f77116ee578f8f8935273c3dea8e29443',
     armv7l: 'f92e7452ca9c62a1605122430c4e184f77116ee578f8f8935273c3dea8e29443',
       i686: '521335d11676f3d80bcd2b03fbcae9582fd4b7fe3ea2e778cd9348692ede97ac',
     x86_64: '32f916f11c5fa28e51d0089466a159b64df185db1cdceb96df6197081ed29b14'
  })

  depends_on 'ruby_abbrev' # R
  depends_on 'ruby_logger' # R

  conflicts_ok
  gem_compile_needed
  no_source_build
end
