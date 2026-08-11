require 'buildsystems/ruby'

class Ruby_rbs < RUBY
  description 'RBS is the language for type signatures for Ruby and standard library definitions.'
  homepage 'https://github.com/ruby/rbs'
  version "4.1.3-#{CREW_RUBY_VER}"
  license 'BSD-2-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '7f6c5b93984ccf388abc106f8d6b95254acd30df5729d0ef41b85925e6984f41',
     armv7l: '7f6c5b93984ccf388abc106f8d6b95254acd30df5729d0ef41b85925e6984f41',
       i686: 'd6eb8590aa1674811d830371a99ad171b3afa51496f95fe4a0e47e5f392398b2',
     x86_64: '08eb815e2653e3295413126c125df49385887d154e50ef92a717c9fd078ec0bf'
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
