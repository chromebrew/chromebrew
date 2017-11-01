require 'package'

class Apriconv < Package
  description 'a portable implementation of the iconv() library'
  homepage 'http://apr.apache.org/'
  version '1.2.1'
  source_url 'http://apache.claz.org/apr/apr-iconv-1.2.1.tar.bz2'
  source_sha256 'c46c919bc2a36a705f91f4dea444b18a83236eef97a417528a988113b3a7e46e'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/apriconv-1.2.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/apriconv-1.2.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/apriconv-1.2.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/apriconv-1.2.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'e9925a67c3f0e1280acf049730a39af4fe7c003835f07fe2e39085d18602e829',
     armv7l: 'e9925a67c3f0e1280acf049730a39af4fe7c003835f07fe2e39085d18602e829',
       i686: 'c3c5809a328a2caab28011f513315c638b3cd8582aaf509e726e6621d7af7132',
     x86_64: '4317c04f0c4b8a44e6a6343077f9e46180d6a32ddc14ac437d69fb35a96b32b0',
  })

  depends_on 'apr'
  depends_on 'libtool'

  def self.build
    system './configure \
            --prefix=/usr/local \
            --with-apr=/usr/local'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    system "libtool --mode=finish #{CREW_DEST_DIR}/usr/local/lib/iconv"
  end
end
