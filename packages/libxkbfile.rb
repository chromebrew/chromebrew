require 'package'

class Libxkbfile < Package
  description 'library for the X window system'
  homepage 'https://x.org'
  version '1.1.1'
  license 'MIT and custom'
  compatibility 'all'
  source_url 'https://www.x.org/archive/individual/lib/libxkbfile-1.1.1.tar.xz'
  source_sha256 '8623dc26e7aac3c5ad8a25e57b566f4324f5619e5db38457f0804ee4ed953443'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxkbfile/1.1.1_armv7l/libxkbfile-1.1.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxkbfile/1.1.1_armv7l/libxkbfile-1.1.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxkbfile/1.1.1_i686/libxkbfile-1.1.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxkbfile/1.1.1_x86_64/libxkbfile-1.1.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '9eafce6985d4c43e7ddef7fb0eb0cfd2f85fb8c2eac0adc78da0099cc5f3093e',
     armv7l: '9eafce6985d4c43e7ddef7fb0eb0cfd2f85fb8c2eac0adc78da0099cc5f3093e',
       i686: '99ebc3d37a50c542f4d14b5743d3b36301daa6f88bb46b1cb14173ffccae80e8',
     x86_64: 'fb124a25ad31cc261459b5e33b2e8aa0d6afc15dc3a1ee29452bd82acfefffed'
  })

  depends_on 'glibc' # R
  depends_on 'libbsd' # R
  depends_on 'libmd' # R
  depends_on 'libx11' # R
  depends_on 'libxau' # R
  depends_on 'libxcb' # R
  depends_on 'libxdmcp' # R

  def self.build
    system '[ -x configure ] || NOCONFIGURE=1 ./autogen.sh'
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
