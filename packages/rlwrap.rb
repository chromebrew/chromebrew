require 'buildsystems/autotools'

class Rlwrap < Autotools
  description 'A readline wrapper'
  homepage 'https://github.com/hanslub42/rlwrap'
  version '0.48'
  license 'GPL-2+'
  compatibility 'all'
  source_url 'https://github.com/hanslub42/rlwrap.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4da021f1ebf34151603c6427e62fed5ac0a4fb11b5f784d767381872d6f5676a',
     armv7l: '4da021f1ebf34151603c6427e62fed5ac0a4fb11b5f784d767381872d6f5676a',
       i686: '3b27998dd713328b832065e21993a410d16caeef8914eb70dc3e0e616b72f888',
     x86_64: '4266e7bc1db04af3c3b207d3193539ae562d9491be7a2c9e3c06dae2aaf84e35'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'libptytty' => :executable
  depends_on 'ncurses' => :executable
  depends_on 'readline' => :executable

  autotools_make_options "CFLAGS='-I#{CREW_PREFIX}/include/ncursesw'"

  def self.patch
    # Fix error: implicit declaration of function ‘tgetent’; did you mean ‘getenv’?
    system "sed -i '22i#include <term.h>' src/term.c"
  end
end
