require 'package'

class Vidstab < Package
  description 'Transcode video stabilization plugin.'
  homepage 'http://public.hronopik.de/vid.stab/'
  version '0.98b'
  source_url 'https://github.com/georgmartius/vid.stab/archive/release-0.98b.tar.gz'
  source_sha256 '530f0bf7479ec89d9326af3a286a15d7d6a90fcafbb641e3b8bdb8d05637d025'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/vidstab-0.98b-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/vidstab-0.98b-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/vidstab-0.98b-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/vidstab-0.98b-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '27057da6800431584c140aaac9d64cb054a03d7e8ad534a4760bc2e5e1d92b3f',
     armv7l: '27057da6800431584c140aaac9d64cb054a03d7e8ad534a4760bc2e5e1d92b3f',
       i686: 'dc7494886a6098c58cd7c6394044aef79df1dd9fad607c38611391147f31d2de',
     x86_64: '7769fa40e362f5914ce80533ec87c6dd61310efb1eddf673a87bf81aa04b404b',
  })

  depends_on 'cmake'

  def self.build
    system "cmake ."
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
