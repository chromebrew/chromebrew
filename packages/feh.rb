require 'package'

class Feh < Package
  description 'feh is an X11 image viewer aimed mostly at console users.'
  homepage 'https://feh.finalrewind.org/'
  version '3.12.2'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/derf/feh.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ede6b228b2378119c56faa7954083f0ea833748f5595d0671c9841902864c4ee',
     armv7l: 'ede6b228b2378119c56faa7954083f0ea833748f5595d0671c9841902864c4ee',
     x86_64: '39210471ede6306c795906607c7a121199275dda0dd20b96f9f5c761406931ee'
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
