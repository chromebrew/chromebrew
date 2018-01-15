require 'package'

class Pango < Package
  description 'Pango is a library for laying out and rendering of text, with an emphasis on internationalization.'
  homepage 'http://www.pango.org/'
  version '1.41'
  source_url 'https://ftp.gnome.org/pub/gnome/sources/pango/1.41/pango-1.41.0.tar.xz'
  source_sha256 '1f76ef95953dc58ee5d6a53e5f1cb6db913f3e0eb489713ee9266695cae580ba'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/pango-1.41-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/pango-1.41-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/pango-1.41-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/pango-1.41-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '67f8f261f2a069225b2858fe6dc622a0a1eb4a04e1172be6e3bb16ce09c21785',
     armv7l: '67f8f261f2a069225b2858fe6dc622a0a1eb4a04e1172be6e3bb16ce09c21785',
       i686: '032ddf476182d20ee2db104abae1bf918db4d14ef931e8011231def15a9eaffc',
     x86_64: '88e9f5e2c23542edbb724011fb1bd9190770de53fcf0c2a382ea4e26ed5579b3',
  })

  depends_on 'diffutils' => :build
  depends_on 'harfbuzz'
  depends_on 'cairo'
  depends_on 'glib'
  depends_on 'perl'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
