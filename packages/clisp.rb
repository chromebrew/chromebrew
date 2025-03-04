require 'buildsystems/autotools'

class Clisp < Autotools
  description 'ANSI Common Lisp compiler, interpreter and debugger.'
  homepage 'https://www.gnu.org/software/clisp/'
  version '2.49-c3ec11b'
  license 'GPL-2+'
  compatibility 'all'
  source_url 'https://gitlab.com/gnu-clisp/clisp.git'
  git_hashtag 'c3ec11bab87cfdbeba01523ed88ac2a16b22304d'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4c54894d371e19acc23ac646653e76c9f27c31027bfc62c1114f04ec036f32e0',
     armv7l: '4c54894d371e19acc23ac646653e76c9f27c31027bfc62c1114f04ec036f32e0',
       i686: 'acd8e9d59a77b3777f0d8071875d57971df39fda44e604ac1ab1f8b13ca27213',
     x86_64: '802d764c61b10b515ac25f7a7299907f464e29b6f911d2c6c0a1e43c2646f72c'
  })

  depends_on 'glibc' # R
  depends_on 'libffcall'
  depends_on 'libsigsegv' # R
  depends_on 'libunistring' # R
  depends_on 'ncurses' # R
  depends_on 'readline'

  def self.build
    system "./configure --fsstnd=gnu --enable-portability #{CREW_CONFIGURE_OPTIONS.sub(/--program-prefix.*/, '')}"
  end

  run_tests
end
