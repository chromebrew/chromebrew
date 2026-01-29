require 'buildsystems/ruby'

class Ruby_syslog < RUBY
  description 'Ruby interface for the posix system logging facility.'
  homepage 'https://github.com/ruby/syslog'
  version "0.4.0-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: 'da6e707a2a116f24ff24551d50ad0a9d6819ff31c6e7bd257e47c2b3d0d48dfc',
     armv7l: 'da6e707a2a116f24ff24551d50ad0a9d6819ff31c6e7bd257e47c2b3d0d48dfc',
       i686: 'f49bf992a4f666abd4bab2aa98ed9d6cb49f5636e0b3141ad797046d3e1cfff0',
     x86_64: 'd66baa5fa2bdbd08f995f2d65657e5e68bfaa7abbc626fbdb61bac5539ff1844'
  })

  depends_on 'glibc' # R
  depends_on 'ruby' # R

  conflicts_ok
  gem_compile_needed
end
