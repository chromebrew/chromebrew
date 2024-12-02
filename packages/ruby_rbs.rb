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
    aarch64: '0b9ec2d04ba88c0a8f3f7a15ec79738b1600eba84219f8f34029389d20329251',
     armv7l: '0b9ec2d04ba88c0a8f3f7a15ec79738b1600eba84219f8f34029389d20329251',
       i686: '884b0d30c23f56ca3826817793e612b6a9c20ba3f1cde8ff587fb91a0aff8817',
     x86_64: '0e0a78e3d391a32f8a0580b4c6bb4922bf77b8f0a6b36f07b61647d77aedf6c2'
  })

  depends_on 'ruby_abbrev' # R
  depends_on 'ruby_logger' # R

  conflicts_ok
  gem_compile_needed
  no_source_build
end
