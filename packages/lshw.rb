require 'package'

class Lshw < Package
  description 'lshw (Hardware Lister) is a small tool to provide detailed information on the hardware configuration of the machine.'
  homepage 'https://ezix.org/project/wiki/HardwareLiSter'
  version '02.20'
  license 'GPL'
  compatibility 'aarch64 armv7l x86_64'
  # Use patched much more recent debian source, as primary source has
  # not been updated for years.
  source_url "https://ezix.org/software/files/lshw-B.#{version}.tar.gz"
  source_sha256 '06d9cf122422220e5dc94e8ea5b01816a69bb6b59368f63d7f21fff31fc6922a'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8750f3da6e986a8f85def4e83c70c55aec5c993250fd86f8f6e0a978df32a942',
     armv7l: '8750f3da6e986a8f85def4e83c70c55aec5c993250fd86f8f6e0a978df32a942',
     x86_64: '4ad53d4589c239f962e3bab6c80d580cece52b1325b512713f1594965b03362d'
  })

  depends_on 'gcc_lib' => :executable
  depends_on 'gdk_pixbuf' => :executable
  depends_on 'glib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'gtk3' => :executable
  depends_on 'hwdata' => :executable
  depends_on 'sqlite' => :executable
  depends_on 'zlib' => :executable

  def self.install
    system "LDFLAGS='-lz -lsqlite3' make DESTDIR=#{CREW_DEST_DIR} NO_VERSION_CHECK=1 VERSION=#{version} ZLIB=1 SQLITE=1 PREFIX=#{CREW_PREFIX} DATADIR=#{CREW_PREFIX}/share MANDIR=#{CREW_MAN_PREFIX} SBINDIR=#{CREW_PREFIX}/bin install"
    system "LDFLAGS='-lz -lsqlite3' make DESTDIR=#{CREW_DEST_DIR} NO_VERSION_CHECK=1 VERSION=#{version} ZLIB=1 SQLITE=1 PREFIX=#{CREW_PREFIX} DATADIR=#{CREW_PREFIX}/share MANDIR=#{CREW_MAN_PREFIX} SBINDIR=#{CREW_PREFIX}/bin install-gui"
  end
end
