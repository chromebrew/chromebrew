require 'package'

class Feh < Package
  description 'feh is an X11 image viewer aimed mostly at console users.'
  homepage 'https://feh.finalrewind.org/'
  version '3.11.4'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/derf/feh.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '705835dff83388989a8df7261bfdf2976756c9cdff75779099d371ff01b6caba',
     armv7l: '705835dff83388989a8df7261bfdf2976756c9cdff75779099d371ff01b6caba',
     x86_64: 'cfcaa5ce038db0b2a728ceb795385cf45b44b42ad0128441592fb3adc3c2a845'
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
