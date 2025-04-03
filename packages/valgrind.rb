require 'buildsystems/autotools'

class Valgrind < Autotools
  description 'Valgrind is an instrumentation framework for building dynamic analysis tools.'
  homepage 'https://valgrind.org/'
  version '3.24.0'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://sourceware.org/git/valgrind.git'
  git_hashtag "VALGRIND_#{version.gsub('.', '_')}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e3c3d347b45971e24cac11925197cc24a2ce43ac25b1131ada88fcc2bb2c94e0',
     armv7l: 'e3c3d347b45971e24cac11925197cc24a2ce43ac25b1131ada88fcc2bb2c94e0',
       i686: 'a7f5d25c1cabe433f876104d06dd7ff6b1a3ec3d242087c58d8af400f2069d13',
     x86_64: '409ed13db4bd493c89df0b1418481baca53cc1836c2392da970e6a99dbadee11'
  })

  depends_on 'glibc' # R
  no_lto
  case ARCH
  when 'aarch64', 'armv7l'
    arch_flags_override
  end
  configure_options (ARCH == 'x86_64' ? '--enable-only64bit' : '--enable-only32bit').to_s
end
