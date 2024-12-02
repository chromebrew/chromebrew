require 'buildsystems/ruby'

class Ruby_rbs < RUBY
  description 'RBS is the language for type signatures for Ruby and standard library definitions.'
  homepage 'https://github.com/ruby/rbs'
  version "3.7.0.dev.1-#{CREW_RUBY_VER}"
  license 'BSD-2-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '9aac42ca5933c04dbe66a9b89dc25eb24539e0554b0f644031447c0ba11b976b',
     armv7l: '9aac42ca5933c04dbe66a9b89dc25eb24539e0554b0f644031447c0ba11b976b',
       i686: '884b0d30c23f56ca3826817793e612b6a9c20ba3f1cde8ff587fb91a0aff8817',
     x86_64: 'b2d3febffd8deae2d7da7e82b107b5f4b6fbc6f101b89c2f4760826f4415dd73'
  })

  depends_on 'ruby_abbrev' # R
  depends_on 'ruby_logger' # R

  conflicts_ok
  gem_compile_needed
  no_source_build
end
