require 'package'

class Pagemon < Package
  description 'Pagemon is an interactive memory/page monitoring tool allowing one to browse the memory map of an active running process.'
  homepage 'https://github.com/ColinIanKing/pagemon'
  version '0.02.06'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/ColinIanKing/pagemon.git'
  git_hashtag "V#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7090fa3616ffe16dec3ea81277531d2062a60374f2cd34467f69fe81ef86a924',
     armv7l: '7090fa3616ffe16dec3ea81277531d2062a60374f2cd34467f69fe81ef86a924',
       i686: 'c0ef52b6e2604f3e13de266c0cb1e6f1c8970eb61093080cd8040d24ea226d32',
     x86_64: 'c42726dffc0d91e416fd3de87a696912b6e375873108db02dc36f9aeb1b341c9'
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
