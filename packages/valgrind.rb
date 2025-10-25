require 'buildsystems/autotools'

class Valgrind < Autotools
  description 'Valgrind is an instrumentation framework for building dynamic analysis tools.'
  homepage 'https://valgrind.org/'
  version '3.26.0'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://sourceware.org/git/valgrind.git'
  git_hashtag "VALGRIND_#{version.gsub('.', '_')}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ca6f5ede527646e74866a5c03bbd470d56b688b301fcc4184da389839fadd6c0',
     armv7l: 'ca6f5ede527646e74866a5c03bbd470d56b688b301fcc4184da389839fadd6c0',
       i686: '8725774a8fbe0db05e9e235e3110b049f8cf0235f17884e261cc661e1470802d',
     x86_64: '620d9201efcf067286c0c09f32707ab7ab8b4b7503995845bc9acc62a06d8d5d'
  })

  depends_on 'glibc' # R
  no_lto
  case ARCH
  when 'aarch64', 'armv7l'
    arch_flags_override
  end
  autotools_configure_options (ARCH == 'x86_64' ? '--enable-only64bit' : '--enable-only32bit').to_s
end
