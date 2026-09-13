require 'package'

class Eventstat < Package
  description 'Eventstat periodically dumps out the current kernel event state.'
  homepage 'https://github.com/ColinIanKing/eventstat'
  version '0.04.12'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/ColinIanKing/eventstat.git'
  git_hashtag "V#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'aa92cd676a30ac214e77478fe74e9a82c63bd559795c18ba012b1cda6c7b5b4b',
     armv7l: 'aa92cd676a30ac214e77478fe74e9a82c63bd559795c18ba012b1cda6c7b5b4b',
       i686: '8f7b1b44aaa60bc3cd235bbee41af86abf1456067dc3d51de9109fc1899e5e9c',
     x86_64: '295c5507f406198cd2249624c575a6a7b3c2e8efb284218e49d0a734ee448619'
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
