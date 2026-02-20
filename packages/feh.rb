require 'package'

class Feh < Package
  description 'feh is an X11 image viewer aimed mostly at console users.'
  homepage 'https://feh.finalrewind.org/'
  version '3.11.3'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/derf/feh.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'dd81242c587bc3ec2dde6f9220e2df4bb28fedb200e248607693b9a2dbf54567',
     armv7l: 'dd81242c587bc3ec2dde6f9220e2df4bb28fedb200e248607693b9a2dbf54567',
     x86_64: '44e4b9f033ae148cad90140ed549e4f249651a8fa370db0c8fa7c9af5f4783b9'
  })

  depends_on 'curl'
  depends_on 'curl' => :executable_only
  depends_on 'glibc' => :executable_only
  depends_on 'gtk3'
  depends_on 'imlib2'
  depends_on 'imlib2' => :executable_only
  depends_on 'libexif'
  depends_on 'libpng'
  depends_on 'libpng' => :executable_only
  depends_on 'libx11'
  depends_on 'libx11' => :executable_only
  depends_on 'libxinerama'
  depends_on 'libxinerama' => :executable_only
  depends_on 'sommelier' => :logical

  def self.build
    system "PREFIX=#{CREW_PREFIX} make"
  end

  def self.install
    system 'make', "PREFIX=#{CREW_PREFIX}", "DESTDIR=#{CREW_DEST_DIR}", "ICON_PREFIX=#{CREW_DEST_PREFIX}/share/icons", 'install'
  end
end
