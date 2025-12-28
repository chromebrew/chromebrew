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
    aarch64: '56dbf983fb57f4c9fd2de679bf536e48292a836af69ac204d9e8c998bdfbf137',
     armv7l: '56dbf983fb57f4c9fd2de679bf536e48292a836af69ac204d9e8c998bdfbf137',
       i686: 'fb6e9fc2c5d816938a06ad8b32e3169223f2961e8f63ea8cdfbef0f03e13cc78',
     x86_64: '045b680143d1fab63b63752c9ddc87957b4d5c2b089c63ce36c234047b7dbf18'
  })

  depends_on 'glibc' # R
  depends_on 'ncurses' # R
  depends_on 'readline' # R
  depends_on 'ruby' # R

  conflicts_ok
  gem_compile_needed
end
