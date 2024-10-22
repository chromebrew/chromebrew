require 'buildsystems/ruby'

class Ruby_sdbm < RUBY
  description 'Provides a simple file-based key-value store with String keys and values.'
  homepage 'https://github.com/ruby/sdbm'
  version "1.0.0-#{CREW_RUBY_VER}"
  license 'BSD-2-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '8cf08be1c22c953862291b9adedb0ad4cfe9fcb1871cd08bbb7cc9fe678ec48f',
     armv7l: '8cf08be1c22c953862291b9adedb0ad4cfe9fcb1871cd08bbb7cc9fe678ec48f',
       i686: '0fcec40c41dce5523928803999f9bbb38736dc079086a906911902b038cb9bca',
     x86_64: 'bc762fd9fad242df80416ab00fe1ba4cff8a778dc9888963d7ee917630e9d830'
  })

  conflicts_ok
  gem_compile_needed
end
