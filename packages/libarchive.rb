require 'package'

class Libarchive < Package
  description 'Multi-format archive and compression library.'
  homepage 'https://www.libarchive.org/'
  version '3.4.0'
  source_url 'https://www.libarchive.org/downloads/libarchive-3.4.0.tar.gz'
  source_sha256 '8643d50ed40c759f5412a3af4e353cffbce4fdf3b5cf321cb72cacf06b2d825e'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libarchive-3.4.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libarchive-3.4.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libarchive-3.4.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libarchive-3.4.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'a1d05d75b8fa0a6addcb8c4a4c52a4eaabe2a5622b6977886a11a830f50f5791',
     armv7l: 'a1d05d75b8fa0a6addcb8c4a4c52a4eaabe2a5622b6977886a11a830f50f5791',
       i686: '96c199ef6abec9f36e3e75403bc8050f38fc5d983b9e8c9a6a848f287ca287a6',
     x86_64: '183af5cc69cf24c59f1914f498ffc374fd4b800e6832e74ae6bec7afc369671b',
  })

  depends_on 'lz4'
  depends_on 'xzutils' => :build

  def self.build
    system "./configure \
          --prefix=#{CREW_PREFIX} \
          --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
