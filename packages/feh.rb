require 'package'

class Feh < Package
  description 'feh is an X11 image viewer aimed mostly at console users.'
  homepage 'https://feh.finalrewind.org/'
  version '3.13'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/derf/feh.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '795fa397ee66a4c0084ddf1b5c41c6cc21302faffdd1213b4db700f0ba6a4393',
     armv7l: '795fa397ee66a4c0084ddf1b5c41c6cc21302faffdd1213b4db700f0ba6a4393',
     x86_64: '19654bbba30e49363a9adbfa3422fcc121e8dff08f601cb123f714cedf193422'
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
