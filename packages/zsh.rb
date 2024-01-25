require 'package'

class Zsh < Package
  description 'Zsh is a shell designed for interactive use, although it is also a powerful scripting language.'
  homepage 'http://zsh.sourceforge.net/'
  version '5.9'
  license 'ZSH and GPL-2'
  compatibility 'all'
  source_url 'https://downloads.sourceforge.net/project/zsh/zsh/5.9/zsh-5.9.tar.xz'
  source_sha256 '9b8d1ecedd5b5e81fbf1918e876752a7dd948e05c1a0dba10ab863842d45acd5'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '712590cb87f8bb45b656c62b5cbbbe6bf06b382ac7dd71e9ed2e750df59c65a6',
     armv7l: '712590cb87f8bb45b656c62b5cbbbe6bf06b382ac7dd71e9ed2e750df59c65a6',
       i686: '83f48b8561ca5b3826eb486c5babbd510276a82837977eb4957b423d7cd3732b',
     x86_64: '296b8325a681d2ff996d1731d88bc1e9b56f82dfa54acfbd7edc31f5e2612829'
  })

  depends_on 'gdbm' # R
  depends_on 'glibc' # R
  depends_on 'ncurses' # R
  depends_on 'gcc_lib' # R
  depends_on 'libcap' # R
  depends_on 'pcre' # R

  def self.build
    system "./configure #{CREW_OPTIONS} \
            --enable-zsh-mem \
            --enable-pcre \
            --enable-cap \
            --enable-gdbm \
            --enable-multibyte"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
