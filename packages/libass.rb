require 'package'

class Libass < Package
  description 'A portable subtitle renderer for the ASS/SSA (Advanced Substation Alpha/Substation Alpha) subtitle format.'
  homepage 'https://github.com/libass/libass'
  version '0.13.6'
  source_url 'https://github.com/libass/libass/archive/0.13.6.tar.gz'
  source_sha256 'de68288397d284a955061b3ecba67152cea74d8ace6222d987dd30091b1534b7'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/libass-0.13.6-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/libass-0.13.6-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/libass-0.13.6-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/libass-0.13.6-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '1eff02012cc3580696ca60461175acb159ef9a1f194d30e5064b40abd58497cd',
     armv7l: '1eff02012cc3580696ca60461175acb159ef9a1f194d30e5064b40abd58497cd',
       i686: '9f67167d8a06be26f6bcd477fc3018af69f658da5b97e82165c0d4ef0d835b51',
     x86_64: '193cf9bc3ebc77fb3882259c75032106837597fd4dbced7d978d829c13e4e5bc',
  })

  depends_on 'automake'
  depends_on 'autoconf'
  depends_on 'freetype'
  depends_on 'fribidi'
  depends_on 'fontconfig'

  def self.build
    system "./autogen.sh"
    system "autoconf"
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
