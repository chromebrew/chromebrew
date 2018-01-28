require 'package'

class Bmon < Package
  description 'bandwidth monitor and rate estimator'
  homepage 'https://github.com/tgraf/bmon/'
  version '4.0'
  source_url 'https://github.com/tgraf/bmon/releases/download/v4.0/bmon-4.0.tar.gz'
  source_sha256 '02fdc312b8ceeb5786b28bf905f54328f414040ff42f45c83007f24b76cc9f7a'

  binary_url ({
  })
  binary_sha256 ({
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
