require 'package'

class Feh < Package
  description 'feh is an X11 image viewer aimed mostly at console users.'
  homepage 'https://feh.finalrewind.org/'
  version '3.10.3'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/derf/feh.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0d18534a578eaf97e8d1557f4f8a253a3a2afa2d78161f6c46a7dedf35c59ff6',
     armv7l: '0d18534a578eaf97e8d1557f4f8a253a3a2afa2d78161f6c46a7dedf35c59ff6',
     x86_64: '59ec39b623a00fde6cdde8dbaf99613b2d952db713907cd7895cf66152c553c5'
  })

  depends_on 'curl'
  depends_on 'gtk3'
  depends_on 'imlib2'
  depends_on 'libexif'
  depends_on 'libpng'
  depends_on 'libx11'
  depends_on 'libxinerama'
  depends_on 'sommelier'

  def self.build
    system "PREFIX=#{CREW_PREFIX} make"
  end

  def self.install
    system 'make', "PREFIX=#{CREW_PREFIX}", "DESTDIR=#{CREW_DEST_DIR}", "ICON_PREFIX=#{CREW_DEST_PREFIX}/share/icons", 'install'
  end
end
