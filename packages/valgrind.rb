require 'buildsystems/autotools'

class Valgrind < Autotools
  description 'Valgrind is an instrumentation framework for building dynamic analysis tools.'
  homepage 'https://valgrind.org/'
  version '3.22-41ff9aa'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://sourceware.org/git/valgrind.git'
  git_hashtag '41ff9aa49f6c54c66d0e6b37f265fd9cb0176057'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e3c3d347b45971e24cac11925197cc24a2ce43ac25b1131ada88fcc2bb2c94e0',
     armv7l: 'e3c3d347b45971e24cac11925197cc24a2ce43ac25b1131ada88fcc2bb2c94e0',
       i686: 'e097e4042c6ae9230b3cbe4ec9e759bc0b6d3a77ed0e7319c4459358a6332998',
     x86_64: 'e3993dab53a717956627fcc39f6050c24852dd72e096158d40ca782d83581418'
  })

  depends_on 'glibc' # R
  no_lto
  case ARCH
  when 'aarch64', 'armv7l'
    arch_flags_override
  end
  configure_options (ARCH == 'x86_64' ? '--enable-only64bit' : '--enable-only32bit').to_s
end
