require 'package'

class Spacefm < Package
  description 'SpaceFM is a multi-panel tabbed file and desktop manager for Linux with built-in VFS, udev- or HAL-based device manager, customisable menu system, and bash-GTK integration.'
  homepage 'https://ignorantguru.github.io/spacefm/'
  version '1.0.6'
  compatibility 'all'
  source_url 'https://github.com/IgnorantGuru/spacefm/archive/1.0.6.tar.gz'
  source_sha256 'fedea9fcad776e0af4b8d90c5a1c86684a9c96ef1cdd4e959530ce93bdebe7c9'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/spacefm-1.0.6-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/spacefm-1.0.6-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/spacefm-1.0.6-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/spacefm-1.0.6-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'a761365160878900f94ad9c964631d2ad29ba0afc3f8d237313f97b9baf60fe0',
     armv7l: 'a761365160878900f94ad9c964631d2ad29ba0afc3f8d237313f97b9baf60fe0',
       i686: '555b7b3a04b73d4aa46ed0551cb6d9577b7e9a1bbe98b0d6ef04b0dedcb94c4a',
     x86_64: '9a347033bb9eb459beddbc793b86f9462f523a28e45250072def822e91adcdf7',
  })

  depends_on 'gtk2'
  depends_on 'gtk3'
  depends_on 'ffmpegthumbnailer'
  depends_on 'hicolor_icon_theme'
  depends_on 'desktop_file_utilities'
  depends_on 'shared_mime_info'
  depends_on 'sommelier'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-maintainer-mode'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
