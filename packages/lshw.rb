require 'package'

class Lshw < Package
  description 'lshw (Hardware Lister) is a small tool to provide detailed information on the hardware configuration of the machine.'
  homepage 'https://ezix.org/project/wiki/HardwareLiSter'
  version 'B.02.19.2-5840f20'
  license 'GPL'
  compatibility 'x86_64 aarch64 armv7l'
  # Use patched much more recent debian source, as primary source has
  # not been updated for years.
  source_url 'https://salsa.debian.org/openstack-team/third-party/lshw.git'
  git_hashtag '5840f2049cdc66115b701cd5a1e332f166cc1743'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '340c681ccf3ec89b89a8587b2d646454b289b7a91780c77e01dfc758668f64f5',
     armv7l: '340c681ccf3ec89b89a8587b2d646454b289b7a91780c77e01dfc758668f64f5',
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
