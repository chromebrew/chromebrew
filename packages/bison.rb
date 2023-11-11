require 'buildsystems/autotools'

class Bison < Autotools
  description 'Bison is a general-purpose parser generator that converts an annotated context-free grammar into a deterministic LR or generalized LR (GLR) parser employing LALR(1) parser tables.'
  homepage 'https://www.gnu.org/software/bison/'
  @_ver = '3.8.2'
  version "#{@_ver}-1"
  license 'GPL-2'
  compatibility 'all'
  source_url "https://ftpmirror.gnu.org/bison/bison-#{@_ver}.tar.lz"
  source_sha256 'fdf98bfe82abb04a34d4356753f7748dbbd2ef1221b1f202852a2b5ce0f78534'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/bison/3.8.2-1_armv7l/bison-3.8.2-1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/bison/3.8.2-1_armv7l/bison-3.8.2-1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/bison/3.8.2-1_i686/bison-3.8.2-1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/bison/3.8.2-1_x86_64/bison-3.8.2-1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '5c7748f4fd47bd81bad984cb278df1561407b43ea3601d2c49ccaa752119dae4',
     armv7l: '5c7748f4fd47bd81bad984cb278df1561407b43ea3601d2c49ccaa752119dae4',
       i686: '8b8120f98e4707695a337d4ac0b21fc0bc26e1a1ee734e4b191420988601d576',
     x86_64: '4476aa49cf42b79a2fed31e77a7d1df7e11aebb3bf269d036c2666d2ab7e238a'
  })

  depends_on 'gettext' # R
  depends_on 'glibc' # R
end
