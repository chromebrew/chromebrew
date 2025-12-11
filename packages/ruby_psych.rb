require 'buildsystems/ruby'

class Ruby_psych < RUBY
  description '| psych is a yaml parser and emitter.'
  homepage 'https://github.com/ruby/psych'
  version "5.3.0-#{CREW_RUBY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '610da8ed270b973da14070bbbf3dba4bcbe194dbd02517eb85adef723ff990e3',
     armv7l: '610da8ed270b973da14070bbbf3dba4bcbe194dbd02517eb85adef723ff990e3',
       i686: 'd8d68f33d37c37d3e2f1e4d196334a76b787d6a51c5a70a26e3189179d9b4f17',
     x86_64: '85719aa00c0a316adaf380653930507fae791f262e3607725b7633669503f29a'
  })

  depends_on 'glibc' # R
  depends_on 'libyaml' # R
  depends_on 'ruby' # R
  depends_on 'ruby_stringio' # R

  conflicts_ok
  gem_compile_needed
  no_source_build
end
