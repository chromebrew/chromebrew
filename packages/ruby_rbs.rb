require 'buildsystems/ruby'

class Ruby_rbs < RUBY
  description 'RBS is the language for type signatures for Ruby and standard library definitions.'
  homepage 'https://github.com/ruby/rbs'
  version "3.9.4-#{CREW_RUBY_VER}"
  license 'BSD-2-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '1089c85ff46961b5a7ea842ce7a7188d165cd3646ad8114ec4c34512e8b1f2f4',
     armv7l: '1089c85ff46961b5a7ea842ce7a7188d165cd3646ad8114ec4c34512e8b1f2f4',
       i686: '507c575a1493d4172702ec1521251e90994807c76fe7040f87220f9d6307d537',
     x86_64: 'eb3ceeaadd3283b1fccff8306ca750608c609153350a0ca0d02963eb34e48678'
  })

  depends_on 'ruby_abbrev' # R
  depends_on 'ruby_logger' # R

  conflicts_ok
  gem_compile_needed
  no_source_build
end
