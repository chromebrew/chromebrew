require 'package'

class Eventstat < Package
  description 'Eventstat periodically dumps out the current kernel event state.'
  homepage 'https://github.com/ColinIanKing/eventstat'
  version '0.06.00'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/ColinIanKing/eventstat.git'
  git_hashtag "V#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9faa4f4d58cb1b796a0e63607ca4a06c904066739dd164c14f3da2e34b03d3c4',
     armv7l: '9faa4f4d58cb1b796a0e63607ca4a06c904066739dd164c14f3da2e34b03d3c4',
       i686: 'd20adfc4a356146816d71df0562e0c9f971de3346e457a684a303464fc089d6e',
     x86_64: '4ab08da1083a697af8827efbcd19e136f40cee0036a7f09f64533646b7b7364d'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'ncurses' => :executable

  print_source_bashrc

  def self.build
    system "CPPFLAGS=-I#{CREW_PREFIX}/include/ncursesw make"
  end

  def self.install
    system 'make',
           "PREFIX=#{CREW_PREFIX}",
           "DESTDIR=#{CREW_DEST_DIR}",
           "BINDIR=#{CREW_PREFIX}/bin",
           "MANDIR=#{CREW_MAN_PREFIX}/man8",
           "BASHDIR=#{CREW_PREFIX}/etc/bash.d",
           'install'
  end
end
