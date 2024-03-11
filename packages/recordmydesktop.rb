require 'package'

class Recordmydesktop < Package
  description 'desktop session recorder for GNU / Linux that attempts to be easy to use'
  homepage 'http://recordmydesktop.sourceforge.net/about.php'
  version '0.3.8.1'
  license 'GPL-2'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://prdownloads.sourceforge.net/project/recordmydesktop/recordmydesktop/0.3.8.1/recordmydesktop-0.3.8.1.tar.gz'
  source_sha256 '33a2e208186ae78e2db2a27b0f5047b50fb7819c47fe15483b0765200b9d738c'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: '9bb5c75a43e50eb5b61598efe09ffc8131c7cbd6fb714b6ca33d3f22a3ff6b86',
     armv7l: '9bb5c75a43e50eb5b61598efe09ffc8131c7cbd6fb714b6ca33d3f22a3ff6b86',
     x86_64: '16fdce8d65a3b57e1167f5edaaf0c8ac2829b27cc38d821d8a64332409349095'
  })

  depends_on 'alsa_plugins'
  depends_on 'libtheora'
  depends_on 'sommelier'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
