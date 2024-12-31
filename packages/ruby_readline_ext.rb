require 'buildsystems/ruby'

class Ruby_readline_ext < RUBY
  description 'Provides an interface for GNU Readline and Edit Line (libedit).'
  homepage 'https://github.com/ruby/readline-ext'
  version "0.2.0-#{CREW_RUBY_VER}"
  license 'BSD-2-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '2d279fe49a1e4288894174f550f1af00e25016faca6bb36ec37baabd566ee1b7',
     armv7l: '2d279fe49a1e4288894174f550f1af00e25016faca6bb36ec37baabd566ee1b7',
       i686: '40344f5aa782feb32a556ac4bb5b9d8f84605f9065d0f7ffd65307a9006b0c7a',
     x86_64: '0e121aa723be9b294b25717b2da9815a92675f540afff310b2f92885ea26f2cc'
  })

  conflicts_ok
  gem_compile_needed
end
