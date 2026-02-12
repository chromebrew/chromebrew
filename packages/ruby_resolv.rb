require 'buildsystems/ruby'

class Ruby_resolv < RUBY
  description 'Thread-aware dns resolver library in ruby.'
  homepage 'https://github.com/ruby/resolv'
  version "0.7.1-#{CREW_RUBY_VER}"
  license 'BSD-2-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '9f3704637fc84af3553396dd8eceff2e7facc04f7b4ad16cd48214c213f5845b',
     armv7l: '9f3704637fc84af3553396dd8eceff2e7facc04f7b4ad16cd48214c213f5845b',
       i686: 'ec9f9dfba6e335d482d032cad141f7e30222825bb19579497c08c2ad7e304ece',
     x86_64: 'ad301b59ec471e674e42e1a528b1d13120658856c98a712dc099b81a3f3fb773'
  })

  conflicts_ok
  gem_compile_needed
end
