require 'buildsystems/ruby'

class Ruby_psych < RUBY
  description '| psych is a yaml parser and emitter.'
  homepage 'https://github.com/ruby/psych'
  version "5.3.1-#{CREW_RUBY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '925308c2256b99645b53e0aae9eea69c752ef8c70e6e30b9cc58364c30b70bc2',
     armv7l: '925308c2256b99645b53e0aae9eea69c752ef8c70e6e30b9cc58364c30b70bc2',
       i686: 'c8b528623746b1607b9ae545d69103b17948757e2b2d2ddef33bda68c63bfbf7',
     x86_64: '37c5a23a436c522557966a48d240f984140f612e8f739d9fc0e13582a7083abb'
  })

  depends_on 'glibc' # R
  depends_on 'libyaml' # R
  depends_on 'ruby' # R
  depends_on 'ruby_stringio' # R

  conflicts_ok
  gem_compile_needed
  no_source_build
end
