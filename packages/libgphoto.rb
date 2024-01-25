require 'package'

class Libgphoto < Package
  description 'The libgphoto2 camera access and control library.'
  homepage 'http://www.gphoto.org/'
  version '2.5.27'
  license 'GPL-2'
  compatibility 'all'
  source_url "https://github.com/gphoto/libgphoto2/archive/libgphoto2-#{version.gsub(/[.]/, '_')}-release.tar.gz"
  source_sha256 '9ac1ab84fc5070d40194181efd0775044220c8d5cdee830386d528710e864ec9'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: 'f3111fd01e63280e864e24c38ac199bff329766a305b8c2b7009c600078bf66b',
     armv7l: 'f3111fd01e63280e864e24c38ac199bff329766a305b8c2b7009c600078bf66b',
       i686: '9f732d1e5202630f789a45645eadf4a7ea012c9acda7db31d1ad92627cf9578a',
     x86_64: '5edaedd9d40c26c2c8462794288b499e72f64b2ce89b42fdc571a64187991110'
  })

  depends_on 'gtk_doc'
  depends_on 'libexif'
  depends_on 'libusb'

  def self.build
    system 'autoreconf --install --symlink'
    system "env CFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      CXXFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      LDFLAGS='-fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      ./configure #{CREW_OPTIONS} \
      --with-camlibs=all,outdated"
    system 'make'
  end

  def self.check
    system 'make', 'check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
