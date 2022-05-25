require 'package'

class Libpciaccess < Package
  description 'Generic PCI access library'
  homepage 'https://x.org'
  version '0.17'
  license 'MIT'
  compatibility 'all'
  source_url 'https://www.x.org/archive/individual/lib/libpciaccess-0.17.tar.xz'
  source_sha256 '74283ba3c974913029e7a547496a29145b07ec51732bbb5b5c58d5025ad95b73'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libpciaccess/0.17_armv7l/libpciaccess-0.17-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libpciaccess/0.17_armv7l/libpciaccess-0.17-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libpciaccess/0.17_i686/libpciaccess-0.17-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libpciaccess/0.17_x86_64/libpciaccess-0.17-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '5c8d971346ea24e2f5bc14de9070e17151943953dbf7efa515b4fb6708a723a5',
     armv7l: '5c8d971346ea24e2f5bc14de9070e17151943953dbf7efa515b4fb6708a723a5',
       i686: '9362cd9b579036b25d29082dc007539145548a6e74db327c18bc805a25d8a875',
     x86_64: 'e61aaa65adb6f1932bc538ed7bb946aec5b6502149931461dec1b9fbf7a58908'
  })

  depends_on 'glibc' # R

  def self.build
    system '[ -x configure ] || NOCONFIGURE=1 ./autogen.sh'
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
