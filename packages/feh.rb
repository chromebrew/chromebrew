require 'package'

class Feh < Package
  description 'feh is an X11 image viewer aimed mostly at console users.'
  homepage 'https://feh.finalrewind.org/'
  version '3.12.1'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/derf/feh.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c3ae03c0832fabfc66ef789fdce672d7de4749e97a72b033022d1606ece83e30',
     armv7l: 'c3ae03c0832fabfc66ef789fdce672d7de4749e97a72b033022d1606ece83e30',
     x86_64: 'ba3500f7c2aa8f7f96d318a5ccfd8e84a8b0d4a1eeedbfd8452e1c6fc5c260b0'
  })

  depends_on 'curl'
  depends_on 'curl' => :executable
  depends_on 'glibc' => :executable
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
