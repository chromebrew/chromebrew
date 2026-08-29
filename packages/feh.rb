require 'package'

class Feh < Package
  description 'feh is an X11 image viewer aimed mostly at console users.'
  homepage 'https://feh.finalrewind.org/'
  version '3.12.4'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/derf/feh.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '43e8e791a8bf4cdabb9fdf6c752fd51f66bf61f3dae4679f2f370fcf8fda4f07',
     armv7l: '43e8e791a8bf4cdabb9fdf6c752fd51f66bf61f3dae4679f2f370fcf8fda4f07',
     x86_64: '860a776a273a44d5a7616f8419e2390f56b9483394eb6d9b381944cb77fba794'
  })

  depends_on 'curl'
  depends_on 'curl' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'gtk3'
  depends_on 'imlib2'
  depends_on 'imlib2' => :executable
  depends_on 'libexif'
  depends_on 'libpng'
  depends_on 'libpng' => :executable
  depends_on 'libx11'
  depends_on 'libx11' => :executable
  depends_on 'libxinerama'
  depends_on 'libxinerama' => :executable
  depends_on 'sommelier' => :logical

  def self.build
    system "PREFIX=#{CREW_PREFIX} make"
  end

  def self.install
    system 'make', "PREFIX=#{CREW_PREFIX}", "DESTDIR=#{CREW_DEST_DIR}", "ICON_PREFIX=#{CREW_DEST_PREFIX}/share/icons", 'install'
  end
end
