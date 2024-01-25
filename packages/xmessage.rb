require 'package'

class Xmessage < Package
  description 'Xmessage displays a message or query in a window.'
  homepage 'https://www.x.org/'
  version '1.0.6'
  license 'MIT-with-advertising'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/xorg/app/xmessage.git'
  git_hashtag "xmessage-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ea8d6e673d1f82e0aa006ee2bc504c6d8704490133e11740fe817cbc2bbe5ecc',
     armv7l: 'ea8d6e673d1f82e0aa006ee2bc504c6d8704490133e11740fe817cbc2bbe5ecc',
       i686: 'edf5fa4b86fa2a7b854d8cda28f85b31d9334e47e285366b23464ede7f06a88a',
     x86_64: '97a8472c63527ae07a93370511899898d7b727669ad27b52a1123f5dc8fadc73'
  })

  depends_on 'glibc' # R
  depends_on 'libx11' # R
  depends_on 'libxaw' # R
  depends_on 'libxt' # R

  def self.build
    system '[ -x configure ] || NOCONFIGURE=1 ./autogen.sh'
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
