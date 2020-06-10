require 'package'

class Gucharmap < Package
  description 'GNOME Character Map, based on the Unicode Character Database.'
  homepage 'https://wiki.gnome.org/Apps/Gucharmap'
  version '10.0.4'
  compatibility 'all'
  source_url 'https://download.gnome.org/sources/gucharmap/10.0/gucharmap-10.0.4.tar.xz'
  source_sha256 'bb266899266b2f2dcdbaf9f45cafd74c6f4e540132d3f0b068d37343291df001'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gucharmap-10.0.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gucharmap-10.0.4-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gucharmap-10.0.4-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gucharmap-10.0.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '074dfb52ebdf428a1f88b12d45902ec1622222ee834eb301858728e06bf36bec',
     armv7l: '074dfb52ebdf428a1f88b12d45902ec1622222ee834eb301858728e06bf36bec',
       i686: '7fb24b94a6c2c7ea4c91ffbe4e1d52124102bb8131932c7a085de9cd1458e35f',
     x86_64: 'ea67e70f52dd53fc6ab9e04c019ae60519a334eb89e077efff201a29d872ca3f',
  })

  depends_on 'desktop_file_utilities'
  depends_on 'itstool'
  depends_on 'vala'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--with-unicode-data=download',
           '--disable-maintainer-mode'
    system "make LIBS='-ldl'"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
