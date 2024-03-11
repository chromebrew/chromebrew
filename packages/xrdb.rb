require 'package'

class Xrdb < Package
  description 'xrdb - X server resource database utility'
  homepage 'https://x.org'
  version '1.2.1'
  license 'custom'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.freedesktop.org/xorg/app/xrdb.git'
  git_hashtag "xrdb-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '547cb971355f8c3a3b4550fde0268150c1ab45cb818c42f21ad3d5bbb93329f8',
     armv7l: '547cb971355f8c3a3b4550fde0268150c1ab45cb818c42f21ad3d5bbb93329f8',
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
