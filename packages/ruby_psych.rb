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
    aarch64: 'd04b8c85942fcd0de52c2ee82703db88a88c1b3455c4e8c22f7b3bf92b786959',
     armv7l: 'd04b8c85942fcd0de52c2ee82703db88a88c1b3455c4e8c22f7b3bf92b786959',
       i686: '174f83906427179f115ac190b9155f6d36243f2310612030f5f9245bbd84b061',
     x86_64: '0c4fae6b05bd50895eb878202c9b5d176f00aa28892298b3f01122e2cc5d978a'
  })

  depends_on 'glibc' # R
  depends_on 'libyaml' # R
  depends_on 'ruby' # R
  depends_on 'ruby_stringio' # R

  conflicts_ok
  gem_compile_needed
  no_source_build
end
