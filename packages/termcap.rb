# Adapted from Arch Linux termcap PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=termcap

require 'package'

class Termcap < Package
  description 'Enables programs to use display computer terminals in a device-independent manner'
  homepage 'http://www.catb.org/~esr/terminfo/'
  version '1.3.1-2'
  license 'GPL'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/termcap/termcap-1.3.1.tar.gz'
  source_sha256 '91a0e22e5387ca4467b5bcb18edf1c51b930262fd466d5fda396dd9d26719100'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/termcap/1.3.1-2_armv7l/termcap-1.3.1-2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/termcap/1.3.1-2_armv7l/termcap-1.3.1-2-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/termcap/1.3.1-2_i686/termcap-1.3.1-2-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/termcap/1.3.1-2_x86_64/termcap-1.3.1-2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'bff907606b3b1d932cbbba5d02a3503809da67519bc457589cf240c515d28b62',
     armv7l: 'bff907606b3b1d932cbbba5d02a3503809da67519bc457589cf240c515d28b62',
       i686: 'b2dafe673b2bb978fb429b9f7beb08a3ed09d19bb5ab391b8053b5dd2fe0ef94',
     x86_64: '99b1526e3629184c0934ad301024400995173e2043a23d35f2f4ebc03127f640'
  })

  depends_on 'glibc' # R

  def self.build
    system 'gcc -fPIC -c termcap.c -DHAVE_STRING_H=1 -DHAVE_UNISTD_H=1 -DSTDC_HEADERS=1'
    system 'gcc -fPIC -c tparam.c -DHAVE_STRING_H=1 -DHAVE_UNISTD_H=1 -DSTDC_HEADERS=1'
    system 'gcc -fPIC -c version.c -DHAVE_STRING_H=1 -DHAVE_UNISTD_H=1 -DSTDC_HEADERS=1'
    system "gcc -shared -Wl,-soname,libtermcap.so \
    -o libtermcap.so.1.3.1 termcap.o tparam.o version.o"
  end

  def self.install
    FileUtils.install 'libtermcap.so.1.3.1', "#{CREW_DEST_LIB_PREFIX}/libtermcap.so.1.3.1", mode: 0o755
    FileUtils.ln_s "#{CREW_LIB_PREFIX}/libtermcap.so.1.3.1", "#{CREW_DEST_LIB_PREFIX}/libtermcap.so"
    FileUtils.install 'termcap.h', "#{CREW_DEST_PREFIX}/include/termcap.h", mode: 0o644
    Dir['termcap.info*'].each do |infofile|
      FileUtils.install infofile, "#{CREW_DEST_PREFIX}/share/info/#{infofile}", mode: 0o644
    end
  end
end
