require 'package'

class Lshw < Package
  description 'lshw (Hardware Lister) is a small tool to provide detailed information on the hardware configuration of the machine.'
  homepage 'https://ezix.org/project/wiki/HardwareLiSter'
  version 'B.02.19.2-5840f20'
  license 'GPL'
  compatibility 'all'
  # Use patched much more recent debian source, as primary source has
  # not been updated for years.
  source_url 'https://salsa.debian.org/openstack-team/third-party/lshw.git'
  git_hashtag '5840f2049cdc66115b701cd5a1e332f166cc1743'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/lshw/B.02.19.2-5840f20_armv7l/lshw-B.02.19.2-5840f20-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/lshw/B.02.19.2-5840f20_armv7l/lshw-B.02.19.2-5840f20-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/lshw/B.02.19.2-5840f20_i686/lshw-B.02.19.2-5840f20-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/lshw/B.02.19.2-5840f20_x86_64/lshw-B.02.19.2-5840f20-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '340c681ccf3ec89b89a8587b2d646454b289b7a91780c77e01dfc758668f64f5',
     armv7l: '340c681ccf3ec89b89a8587b2d646454b289b7a91780c77e01dfc758668f64f5',
       i686: '23db0e32239b32e32d6f83eface0436de25de3d03e166b21638ba8ba49a59742',
     x86_64: 'ae50b29d704bfbffb72c166b9b30e37516e83bebe385c223252cd8f4be6c9ed8'
  })

  depends_on 'hwdata'
  depends_on 'gcc_lib' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gtk3' # R (but not needed for the CLI app)
  depends_on 'sqlite' # R
  depends_on 'zlibpkg' # R

  def self.build; end

  def self.install
    system "LDFLAGS='-lz -lsqlite3' make DESTDIR=#{CREW_DEST_DIR} NO_VERSION_CHECK=1 VERSION=#{version} ZLIB=1 SQLITE=1 PREFIX=#{CREW_PREFIX} DATADIR=#{CREW_PREFIX}/share MANDIR=#{CREW_MAN_PREFIX} SBINDIR=#{CREW_PREFIX}/bin install"
    system "LDFLAGS='-lz -lsqlite3' make DESTDIR=#{CREW_DEST_DIR} NO_VERSION_CHECK=1 VERSION=#{version} ZLIB=1 SQLITE=1 PREFIX=#{CREW_PREFIX} DATADIR=#{CREW_PREFIX}/share MANDIR=#{CREW_MAN_PREFIX} SBINDIR=#{CREW_PREFIX}/bin install-gui"
  end
end
