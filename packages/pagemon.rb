require 'package'

class Pagemon < Package
  description 'Pagemon is an interactive memory/page monitoring tool allowing one to browse the memory map of an active running process.'
  homepage 'https://github.com/ColinIanKing/pagemon'
  version '0.02.05'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/ColinIanKing/pagemon.git'
  git_hashtag "V#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '03bc0311994ece280d5511d97847503c2e2793c037cc9225367fe9d5eca5c00e',
     armv7l: '03bc0311994ece280d5511d97847503c2e2793c037cc9225367fe9d5eca5c00e',
       i686: '80cef6fd289eaf68c841491cd76dae1a4b7e043484fdef66860ca1e3f5433670',
     x86_64: '9efa248be2e4d1be3d420051ea17c17aaafa3232b63efa4ee6e98cb89499acab'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'ncurses' => :executable

  print_source_bashrc

  def self.patch
    system "sed -i 's,/usr,#{CREW_PREFIX},g' Makefile"
    system "sed -i 's,<ncurses.h>,<#{CREW_PREFIX}/include/ncursesw/ncurses.h>,' pagemon.c"
  end

  def self.build
    system 'make'
    File.write '10-pagemon', <<~EOF
      #!/bin/bash
      source #{CREW_PREFIX}/share/bash-completion/completions/pagemon
    EOF
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    FileUtils.install '10-pagemon', "#{CREW_DEST_PREFIX}/etc/bash.d/10-pagemon"
  end
end
