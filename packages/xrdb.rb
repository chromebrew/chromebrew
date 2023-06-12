require 'package'

class Xrdb < Package
  description 'xrdb - X server resource database utility'
  homepage 'https://x.org'
  version '1.2.1'
  license 'custom'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/xorg/app/xrdb.git'
  git_hashtag "xrdb-#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xrdb/1.2.1_armv7l/xrdb-1.2.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xrdb/1.2.1_armv7l/xrdb-1.2.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xrdb/1.2.1_i686/xrdb-1.2.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xrdb/1.2.1_x86_64/xrdb-1.2.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '547cb971355f8c3a3b4550fde0268150c1ab45cb818c42f21ad3d5bbb93329f8',
     armv7l: '547cb971355f8c3a3b4550fde0268150c1ab45cb818c42f21ad3d5bbb93329f8',
       i686: '5751bc4b403de795dc53c34a0aef60714bb6c45a318032510e791b3c37622af2',
     x86_64: '5725f1b269c6ec44f0c975bed5575299f7896105637a7e34cd4f967cee808207'
  })

  depends_on 'libx11' # R
  depends_on 'libxmu' # R
  depends_on 'libxdmcp' => :build

  def self.build
    system 'NOCONFIGURE=1 ./autogen.sh'
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
