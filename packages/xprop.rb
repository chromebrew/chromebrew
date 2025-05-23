require 'package'

class Xprop < Package
  description 'Xprop is a property displayer for X.'
  homepage 'https://www.x.org/wiki/'
  version '1.2.6'
  license 'MIT-with-advertising and ISC'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/xorg/app/xprop.git'
  git_hashtag "xprop-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '29b6c1397a06c4b4691ffb044d6ad1e9ab6686b1c3b6c8dffbbb195a09499d38',
     armv7l: '29b6c1397a06c4b4691ffb044d6ad1e9ab6686b1c3b6c8dffbbb195a09499d38',
     x86_64: '0121b423cdce35f7dafd41a9aaf8199cd2d69eb3fda164c69058354f545e08c6'
  })

  depends_on 'glibc' # R
  depends_on 'libx11' # R

  def self.build
    system '[ -x configure ] || NOCONFIGURE=1 ./autogen.sh'
    system "./configure #{CREW_CONFIGURE_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
