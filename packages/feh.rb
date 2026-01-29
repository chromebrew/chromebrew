require 'package'

class Feh < Package
  description 'feh is an X11 image viewer aimed mostly at console users.'
  homepage 'https://feh.finalrewind.org/'
  version '3.11.2'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/derf/feh.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c9a30dc72fa0757ab043309b13ea2831164e863a9b12112037244e88a4b9710a',
     armv7l: 'c9a30dc72fa0757ab043309b13ea2831164e863a9b12112037244e88a4b9710a',
     x86_64: 'cca070d8b0846c7079d864566e6a567196cb9db78d2db5bc395572df426f9d1c'
  })

  depends_on 'curl'
  depends_on 'glibc' # R
  depends_on 'gtk3'
  depends_on 'imlib2'
  depends_on 'libexif'
  depends_on 'libpng'
  depends_on 'libx11'
  depends_on 'libxinerama'
  depends_on 'sommelier' => :logical

  def self.build
    system "PREFIX=#{CREW_PREFIX} make"
  end

  def self.install
    system 'make', "PREFIX=#{CREW_PREFIX}", "DESTDIR=#{CREW_DEST_DIR}", "ICON_PREFIX=#{CREW_DEST_PREFIX}/share/icons", 'install'
  end
end
