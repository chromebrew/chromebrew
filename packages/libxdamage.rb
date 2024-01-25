require 'package'

class Libxdamage < Package
  description 'library for the X window system'
  homepage 'https://x.org'
  version '1.1.6'
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/xorg/lib/libxdamage.git'
  git_hashtag "libXdamage-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1acd0ec73124faf374844894ebbaa792e985272284c5ff544c93499c3b6d8e2f',
     armv7l: '1acd0ec73124faf374844894ebbaa792e985272284c5ff544c93499c3b6d8e2f',
       i686: 'af9d5094cd0eb74f4555c75c9133b34f4954b44dcd04101004355373148f42d4',
     x86_64: '122712b7c3630e9d849fa134d94201437da15ff1cda107d9932cc3a39d08d6c4'
  })

  depends_on 'glibc' # R
  depends_on 'libbsd' # R
  depends_on 'libmd' # R
  depends_on 'libx11' # R
  depends_on 'libxau' # R
  depends_on 'libxcb' # R
  depends_on 'libxdmcp' # R
  depends_on 'libxfixes' # R

  def self.build
    system '[ -x configure ] || NOCONFIGURE=1 ./autogen.sh'
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system 'make', 'check'
  end
end
