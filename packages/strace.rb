require 'package'

class Strace < Package
  description 'strace is a diagnostic, debugging and instructional userspace utility for Linux.'
  homepage 'https://strace.io/'
  version '5.1'
  source_url 'https://github.com/strace/strace/releases/download/v5.1/strace-5.1.tar.xz'
  source_sha256 'f5a341b97d7da88ee3760626872a4899bf23cf8dee56901f114be5b1837a9a8b'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/strace-5.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/strace-5.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/strace-5.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/strace-5.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'd686b3b6f03f2c527a81825a5ed23450762156e99045013c4d92b83a8e48fca4',
     armv7l: 'd686b3b6f03f2c527a81825a5ed23450762156e99045013c4d92b83a8e48fca4',
       i686: '403ffd87e7c1d7c8e0aa778f3df5e25fc5a5838158c950b1e279e8180437bcdb',
     x86_64: '1695f03c2c5ba9c143ae2282cd4d53421f41e0bbb28369b38795a248fe787440',
  })

  depends_on 'buildessential'

  def self.build
    system "./configure",
      "--prefix=#{CREW_PREFIX}",
      "--libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
