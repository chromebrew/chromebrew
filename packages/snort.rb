require 'package'

class Snort < Package
  description 'Snort is an open source intrusion prevention system capable of real-time traffic analysis and packet logging.'
  homepage 'https://www.snort.org/'
  version '2.9.11.1'
  compatibility 'all'
  source_url 'https://www.snort.org/downloads/snort/snort-2.9.11.1.tar.gz'
  source_sha256 '9f6b3aeac5a109f55504bd370564ac431cb1773507929dc461626898f33f46cd'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/snort-2.9.11.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/snort-2.9.11.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/snort-2.9.11.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/snort-2.9.11.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '8f12b124f9542264c22d29a337be0b84899289dbbcb8c533540aebb792d2e955',
     armv7l: '8f12b124f9542264c22d29a337be0b84899289dbbcb8c533540aebb792d2e955',
       i686: '92b82274782ba2af2365615f1652a24f0d5d330e4f501fe82328699fbc364f9f',
     x86_64: '7f0a4f0c370300784ac9216c490055b636ecb3f3d846c6447f8835f800ba81e7',
  })

  depends_on 'daq'
  depends_on 'libdnet'
  depends_on 'libtirpc'
  depends_on 'pcre'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--enable-sourcefire'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
