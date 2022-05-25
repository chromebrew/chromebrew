require 'package'

class Libxdmcp < Package
  description 'The libXdmcp package contains a library implementing the X Display Manager Control Protocol.'
  homepage 'http://www.x.org'
  version '4a71fdf'
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/xorg/lib/libxdmcp.git'
  git_hashtag '4a71fdf6d34df67d3f1335590da6ae3050128fb2'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxdmcp/4a71fdf_armv7l/libxdmcp-4a71fdf-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxdmcp/4a71fdf_armv7l/libxdmcp-4a71fdf-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxdmcp/4a71fdf_i686/libxdmcp-4a71fdf-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxdmcp/4a71fdf_x86_64/libxdmcp-4a71fdf-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '591a059b27c7095f45adf57a4d1ac4b045fb2e6be8ea55bac8aa2b2eef1b3c16',
     armv7l: '591a059b27c7095f45adf57a4d1ac4b045fb2e6be8ea55bac8aa2b2eef1b3c16',
       i686: 'a91f416ab907be4f4183b4c5da505e4d25586736b22185e3f58b64c36a1f9ca1',
     x86_64: '553304325808a09bc564a989a1e727046000b892ce75d1dec437df7d67ade648'
  })

  depends_on 'libbsd' # R
  depends_on 'libmd' # R
  depends_on 'xorg_proto'

  def self.build
    system 'NOCONFIGURE=1 ./autogen.sh'
    system 'filefix'
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
