require 'package'

class Libgphoto < Package
  description 'The libgphoto2 camera access and control library.'
  homepage 'http://www.gphoto.org/'
  version '2.5.33'
  license 'GPL-2'
  compatibility 'all'
  source_url "https://github.com/gphoto/libgphoto2/archive/libgphoto2-#{version.gsub(/[.]/, '_')}-release.tar.gz"
  source_sha256 '7643f322dfda5668150d0cfdec5e4f87669f69b630106f72211fb5ff6aca2ce8'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '695f6b836e51fc2356afb29033f7c87987aa6cf9b17b43798623d524e70c6b87',
     armv7l: '695f6b836e51fc2356afb29033f7c87987aa6cf9b17b43798623d524e70c6b87',
       i686: '9a03d6a63969fde796dc6deeeb9034b8356164a6a8575ba931056f096633b5e6',
     x86_64: 'e817d44ecf2c8916088917a6d93eb648aebb0ecc839e589b4206aa2a163265d8'
  })

  depends_on 'gtk_doc'
  depends_on 'libexif'
  depends_on 'libusb'

  def self.build
    system 'autoreconf --install --symlink'
    system "env CFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      CXXFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      LDFLAGS='-fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      ./configure #{CREW_CONFIGURE_OPTIONS} \
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
