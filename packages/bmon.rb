require 'package'

class Bmon < Package
  description 'bandwidth monitor and rate estimator'
  homepage 'https://github.com/tgraf/bmon/'
  version '4.0'
  compatibility 'all'
  source_url 'https://github.com/tgraf/bmon/releases/download/v4.0/bmon-4.0.tar.gz'
  source_sha256 '02fdc312b8ceeb5786b28bf905f54328f414040ff42f45c83007f24b76cc9f7a'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/bmon-4.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/bmon-4.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/bmon-4.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/bmon-4.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '1152f984aae1b54b4162a34460a8b3ced0be7e3c8a0887ac02fbd9d283cbd5aa',
     armv7l: '1152f984aae1b54b4162a34460a8b3ced0be7e3c8a0887ac02fbd9d283cbd5aa',
       i686: '5507412038511d2f5315478d3f527e54be02b3b9d69381aa1fbdf5a36621a5e0',
     x86_64: 'e12f42c3d028678a37bf083ca9884ab4ad453de414f57a63eedec43c08705146',
  })

  depends_on 'libconfuse'
  depends_on 'libnl3'
  depends_on 'ncurses'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
