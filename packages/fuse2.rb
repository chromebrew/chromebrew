require 'package'

class Fuse2 < Package
  description 'The reference implementation of the Linux FUSE (Filesystem in Userspace) interface.'
  homepage 'https://github.com/libfuse/libfuse'
  version '2.9.9'
  license 'GPL-2+'
  compatibility 'all'
  source_url "https://github.com/libfuse/libfuse/releases/download/fuse-#{version}/fuse-#{version}.tar.gz"
  source_sha256 'd0e69d5d608cc22ff4843791ad097f554dd32540ddc9bed7638cc6fea7c1b4b5'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: '9ce364381c48373457a05ba46e5d9bb25bd4067191d2172afd88f8a51fa5c218',
     armv7l: '9ce364381c48373457a05ba46e5d9bb25bd4067191d2172afd88f8a51fa5c218',
       i686: '0181877ec4a17f5eedaa10a8e109622cb4960866de600c2f492d421506074c72',
     x86_64: 'db93cd8c0f30caf6fcd6a56201262b1fdcb53e827697069020e43a1ccde4c971'
  })

  depends_on 'util_linux'

  def self.build
    system "./configure #{CREW_OPTIONS} \
            --enable-example \
            --disable-mtab \
            --enable-util \
            --enable-lib"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
