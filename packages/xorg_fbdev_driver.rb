require 'buildsystems/autotools'

class Xorg_fbdev_driver < Autotools
  description 'The Xorg Fbdev Driver package contains the X.Org Video Driver for framebuffer devices. This driver is often used as fallback driver if the hardware specific and VESA drivers fail to load or are not present.'
  homepage 'https://www.x.org/wiki/'
  version '0.5.1'
  license 'MIT-with-advertising'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/xorg/driver/xf86-video-fbdev.git'
  git_hashtag "xf86-video-fbdev-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e56f667e50ae7362843182aa111a64cd2c1386a09e14ca866dc3cb485b5adf62',
     armv7l: 'e56f667e50ae7362843182aa111a64cd2c1386a09e14ca866dc3cb485b5adf62',
     x86_64: 'af909ad6809b43a7e04f5b3669b40e355d15c7e45185926daf82f9b2e0276531'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'xorg_server' => :build

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install-strip'
  end
end
