require 'buildsystems/ruby'

class Ruby_debug < RUBY
  description 'The debug library provides debugging functionality to Ruby (MRI) 2.7 and later.'
  homepage 'https://github.com/ruby/debug'
  version "1.9.2-#{CREW_RUBY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '7bbdab6908ec124f2cfaaf6d93c23a522018993ff4426cf5274160bc2eb7836e',
     armv7l: '7bbdab6908ec124f2cfaaf6d93c23a522018993ff4426cf5274160bc2eb7836e',
       i686: '9403b227db36447ab2cf41eed7cb63b3ac9703dd2deddd1d7297eda38a8eab12',
     x86_64: '2b701d2dd3b61b89da53aa557d5d88ce031fe3ac959f4ff0d966ca62bc504dc1'
  })

  depends_on 'ruby_reline' # R

  depends_on 'ruby_irb' # R

  conflicts_ok
  gem_compile_needed
  no_source_build
end
