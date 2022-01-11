require 'package'

class Libxdmcp < Package
  description 'The libXdmcp package contains a library implementing the X Display Manager Control Protocol.'
  homepage 'http://www.x.org'
  @_ver = '1.1.3'
  version "#{@_ver}-2"
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/xorg/lib/libxdmcp.git'
  git_hashtag "libXdmcp-#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxdmcp/1.1.3-2_armv7l/libxdmcp-1.1.3-2-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxdmcp/1.1.3-2_armv7l/libxdmcp-1.1.3-2-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxdmcp/1.1.3-2_i686/libxdmcp-1.1.3-2-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxdmcp/1.1.3-2_x86_64/libxdmcp-1.1.3-2-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'a1540e554724bfb3f0eb2525e332c6a5b47d15827596c5d163af7b6efb7c16dd',
     armv7l: 'a1540e554724bfb3f0eb2525e332c6a5b47d15827596c5d163af7b6efb7c16dd',
       i686: 'c638d631e3b94580f8e4060a561bf1867e9daaf3ea05d3015469a982bf88b1ca',
     x86_64: '7567bb45cc60b081c21b72c1526ffb3f9b5bb1016bb3737405bbcd5a4a85a3b7'
  })

  depends_on 'xorg_proto'

  def self.build
    system './autogen.sh'
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
