require 'package'

class Xfce4_terminal < Package
  description 'Modern terminal emulator primarly for the Xfce desktop environment'
  homepage 'https://xfce.org/'
  version '0.8.9'
  compatibility 'all'
  source_url 'https://archive.xfce.org/src/apps/xfce4-terminal/0.8/xfce4-terminal-0.8.9.tar.bz2'
  source_sha256 '247683a51a964cfaa6b1e92030afe9f782efebfcb550a464170b53eb94216795'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/xfce4_terminal-0.8.9-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/xfce4_terminal-0.8.9-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/xfce4_terminal-0.8.9-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/xfce4_terminal-0.8.9-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'd37498733609e4d3f3f15850338c4784a4eb78a004e7e25acf77931926e10bfc',
     armv7l: 'd37498733609e4d3f3f15850338c4784a4eb78a004e7e25acf77931926e10bfc',
       i686: '9840a888716501c16051c3d5bd1e2589041842e5ce04752e5ad4ccca1040d220',
     x86_64: '8de24a4111db8171a242bf6a0365c9cb491fdcd472909fef82dce15a11f51d20',
  })

  depends_on 'desktop_file_utilities'
  depends_on 'gtkvte'
  depends_on 'exo' => :build
  depends_on 'hicolor_icon_theme'
  depends_on 'startup_notification'
  depends_on 'sommelier'

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system "make -j#{CREW_NPROC}"
  end

  def self.install
    system "make install DESTDIR=#{CREW_DEST_DIR}"
  end
end
