require 'package'

class Fuse2 < Package
  description 'The reference implementation of the Linux FUSE (Filesystem in Userspace) interface.'
  homepage 'https://github.com/libfuse/libfuse'
  version '2.9.9'
  license 'GPL-2+'
  compatibility 'all'
  source_url "https://github.com/libfuse/libfuse/releases/download/fuse-#{version}/fuse-#{version}.tar.gz"
  source_sha256 'd0e69d5d608cc22ff4843791ad097f554dd32540ddc9bed7638cc6fea7c1b4b5'

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
