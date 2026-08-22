require 'buildsystems/ruby'

class Ruby_psych < RUBY
  description '| psych is a yaml parser and emitter.'
  homepage 'https://github.com/ruby/psych'
  version "5.5.0-#{CREW_RUBY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: 'c3544d7a86548dc4b3c5ee53740a1b0d65a62fa8c4dd1a9a71c155829b813808',
     armv7l: 'c3544d7a86548dc4b3c5ee53740a1b0d65a62fa8c4dd1a9a71c155829b813808',
       i686: '7ab236da3b62634c721d324db027f6ca6d5f5eb1ffc0d163d44a9b19f6f7f83a',
     x86_64: 'b83f252b1ba754e7404d9cf3e37b07a07e66ee75620d0be2524f3582c7eae294'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libyaml' => :library
  depends_on 'ruby' => :library
  depends_on 'ruby_stringio' # R

  conflicts_ok
  gem_compile_needed
  no_source_build
end
