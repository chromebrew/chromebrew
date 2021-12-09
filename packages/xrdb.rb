require 'package'

class Xrdb < Package
  description 'xrdb - X server resource database utility'
  homepage 'https://x.org'
  @_ver = '1.2.1'
  version @_ver
  license 'custom'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/xorg/app/xrdb.git'
  git_hashtag "xrdb-#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xrdb/1.2.1_armv7l/xrdb-1.2.1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xrdb/1.2.1_armv7l/xrdb-1.2.1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xrdb/1.2.1_i686/xrdb-1.2.1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xrdb/1.2.1_x86_64/xrdb-1.2.1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '11a324366e42a9c4fbf4320d11ef95278f17b82fc5f0705c24e2dd66a2f56ddc',
     armv7l: '11a324366e42a9c4fbf4320d11ef95278f17b82fc5f0705c24e2dd66a2f56ddc',
       i686: 'bfc03bdeccf7e972596f4013d9a330cc80c497758eb8f6e83dd95fcea0d9f6f4',
     x86_64: 'c2d3a29dcac7878fded1af3defcb768930db7c4f4c973dd8f11dcd191dc00566'
  })

  depends_on 'libx11' # R
  depends_on 'libxmu' # R
  depends_on 'libxdmcp' => :build

  def self.build
    system 'NOCONFIGURE=1 ./autogen.sh'
    system "#{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
