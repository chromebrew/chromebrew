require 'package'

class Nmon < Package
  description "nmon is short for Nigel's performance MONitor for Linux"
  homepage 'https://nmon.sourceforge.io/pmwiki.php'
  version '16s'
  license 'GPL-3'
  compatibility 'all'
  source_url "https://downloads.sourceforge.net/project/nmon/lmon#{version}.c"
  source_sha256 '0736ce0f729e48c124a7ba566c069c5a234511cc9c6ac9277da92f8bb44f2b11'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a2ec115cc91eeaf987b538c8a3be11ff9aafa47d64e46c142bd665c55ffc2cb5',
     armv7l: 'a2ec115cc91eeaf987b538c8a3be11ff9aafa47d64e46c142bd665c55ffc2cb5',
       i686: 'fbe6bf9234e9685aad02ea2798c202d2dad9019cc53ae4fd332fb5a02ed3e774',
     x86_64: 'fa566c10833700f66e320b16af52fbe6d396b505abe2b39f741b613aa2090ff3'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'ncurses' => :executable

  def self.patch
    system "sed -i 's,<ncurses.h>,<#{CREW_PREFIX}/include/ncurses/ncurses.h>,' lmon#{version}.c"
  end

  def self.build
    system "cc -o nmon lmon#{version}.c -g -O3 -Wall -D JFS -D GETUSER -D LARGEMEM -lncurses -lm -g -D POWER"
  end

  def self.install
    FileUtils.install 'nmon', "#{CREW_DEST_PREFIX}/bin/nmon", mode: 0o755
  end
end
