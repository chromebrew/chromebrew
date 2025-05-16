require 'buildsystems/ruby'

class Ruby_rbs < RUBY
  description 'RBS is the language for type signatures for Ruby and standard library definitions.'
  homepage 'https://github.com/ruby/rbs'
  version "3.9.3-#{CREW_RUBY_VER}"
  license 'BSD-2-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '1089c85ff46961b5a7ea842ce7a7188d165cd3646ad8114ec4c34512e8b1f2f4',
     armv7l: '1089c85ff46961b5a7ea842ce7a7188d165cd3646ad8114ec4c34512e8b1f2f4',
       i686: 'd10e30e9bd196878b722744061eb486a7589111e2b8c8256f2d5dbcb8cc85537',
     x86_64: '6faf935b0a6763fb4a7677863b8e0f6f135a9c6d5cb71569becdbd29f34974e3'
  })

  depends_on 'ruby_abbrev' # R
  depends_on 'ruby_logger' # R

  conflicts_ok
  gem_compile_needed
  no_source_build
end
