require 'package'

class Lxappearance < Package
  description 'LXDE Theme Switcher'
  homepage 'http://lxde.org/'
  version '0.6.3'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://downloads.sourceforge.net/sourceforge/lxde/lxappearance-0.6.3.tar.xz'
  source_sha256 '7222d858b8fef4b7967c42142d61e82ded6dd42dc5ef1d59caad775795928b38'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: 'e03262c2c8dda002b214e1ac5a9ab9a41833df883f7517d629cc394f48684356',
     armv7l: 'e03262c2c8dda002b214e1ac5a9ab9a41833df883f7517d629cc394f48684356',
       i686: 'e6e68b1dba05ffc4fad62b722eca5a4a9b3b7d5c0acda0d72682de16aaf1f2bd',
     x86_64: 'd3a30b2f4e1ad3e2c281ee39867edc2dddeaec62295ccd0a348422ac0685ca93'
  })

  depends_on 'gtk3'
  depends_on 'desktop_file_utilities'
  depends_on 'dbus_glib'

  def self.build
    system "./configure #{CREW_OPTIONS} --enable-gtk3 --enable-dbus"
    system "make -j#{CREW_NPROC}"
  end

  def self.install
    system "make install DESTDIR=#{CREW_DEST_DIR}"
  end
end
