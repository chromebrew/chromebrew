require 'buildsystems/ruby'

class Ruby_rbs < RUBY
  description 'RBS is the language for type signatures for Ruby and standard library definitions.'
  homepage 'https://github.com/ruby/rbs'
  version "3.9.0-#{CREW_RUBY_VER}"
  license 'BSD-2-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: 'fb08c7a4ae60e63a3f89b79812e7ac1b40b1ea3d0443501b263219884b8360bf',
     armv7l: 'fb08c7a4ae60e63a3f89b79812e7ac1b40b1ea3d0443501b263219884b8360bf',
       i686: '9a7ab8519738f6a7fe29db44e7e603d4964301f5e6e6035a8d1a87765b79c3f2',
     x86_64: 'd2d3178becf860898c8f4ebdadcbefef31f0a75e1cc484829ff14313f613c7b7'
  })

  depends_on 'ruby_abbrev' # R
  depends_on 'ruby_logger' # R

  conflicts_ok
  gem_compile_needed
  no_source_build
end
