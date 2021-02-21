require 'package'

class Canfield < Package
  description 'The solitaire card game canfield'
  homepage 'https://www.polyomino.org.uk/computer/software/bsd-games/'
  version '2.17'
  compatibility 'all'
  source_url 'https://www.polyomino.org.uk/computer/software/bsd-games/bsd-games-2.17.tar.gz'
  source_sha256 '066f924aef6c1c5ea946f588e36f303021f5dfc093944738f025d8edbc6fff60'

  depends_on 'miscfiles'
  depends_on 'words'
  depends_on 'less'
  
  @_bsdgame = 'canfield'
  
  def self.patch
    FileUtils.mkdir 'patches'
    Dir.chdir 'patches' do
      # Download patches
      puts 'Downloading patches'.lightblue
      system "curl -#LO https://raw.github.com/gentoo/gentoo/ac439edc59f851483ecb9f732f9e5c65aa057224/games-misc/bsd-games/files/bsd-games-2.17-64bitutmp.patch"
      system "curl -#LO https://raw.github.com/gentoo/gentoo/ac439edc59f851483ecb9f732f9e5c65aa057224/games-misc/bsd-games/files/bsd-games-2.17-bg.patch"
      system "curl -#LO https://raw.github.com/gentoo/gentoo/ac439edc59f851483ecb9f732f9e5c65aa057224/games-misc/bsd-games/files/bsd-games-2.17-gcc4.patch"
      system "curl -#LO https://httpredir.debian.org/debian/pool/main/b/bsdgames/bsdgames_2.17-28.debian.tar.xz"
      # Verify patches
      puts 'Verifying patches'.lightblue
      @sha256sums = <<~EOF
        992f8602661cc41c3253317bfc157abe0b2041cd7d32f5a31811708e2f8c4e23  bsd-games-2.17-64bitutmp.patch
        d25eb2b0e6790b6a852bce08f384994fed7b37a9d33d12d01b65e67fbd8f67d7  bsd-games-2.17-bg.patch
        96639f25206401c0dde3f9f28ac287c9e26c3efb526481fa48b482f8c9ab4ac0  bsd-games-2.17-gcc4.patch
        71dfc6b91b4529afcd9147fc2646930f979d083a0713ec7f2aace8c476cf5ab8  bsdgames_2.17-28.debian.tar.xz
      EOF
      IO.write("sha256sums", @sha256sums)
      system "sha256sum -c sha256sums"
      # Extract patches
      puts 'Patching'.lightblue
      system "tar xf bsdgames_2.17-28.debian.tar.xz"
      # Patch patches :/
      system "sed -i 's:backgammon/common_source/fancy.c.old:backgammon/common_source/fancy.c:g' bsd-games-2.17-bg.patch"
      system "sed -i 's:bsd-games/dm/utmpentry.c:dm/utmpentry.c:g' bsd-games-2.17-64bitutmp.patch"
      FileUtils.rm 'debian/patches/0006-Custom-configuration-of-Debian-package-build.patch' # Don't add a dependency on dpkg
      FileUtils.rm 'debian/patches/0007-Unsorted-Debian-patches.patch'
    end
    # Patch
    system "for patch in patches/*.patch; do patch -i ${patch} -p 0; done" # Apply gentoo's patches
    system "for patch in patches/debian/patches/*.patch; do patch -t -p 1 -i ${patch}; done" # Apply debian's patches
    system "sed -i 's:-lncurses:-lncurses -ltinfo:g' configure" # Add libtinfo support
    system "sed -i 's:-lcrypto:-lssl -lcrypto:g' configure" # Fix openssl
    system "sed -i 's:#!/bin/sh:#!/bin/bash:' configure" # dash doesn't work
    system "sed -i 's:read input:read -t 0.2 input:' configure" # Make script automatic
  end
  
  def self.prebuild
    puts 'Configuring'.lightblue
    system "sed -i 's:-g -O2:-O2:g' configure"
    system "sed -i 's:/usr/games:#{CREW_PREFIX}/bin:' wargames/wargames"
    system "echo bsd_games_cfg_build_dirs='\"#{@_bsdgame}\"' >> config.params"
    system "echo bsd_games_cfg_docdir='#{CREW_PREFIX}/share/doc/bsdgames' >> config.params"
    system "echo bsd_games_cfg_install_prefix='#{CREW_DEST_DIR}' >> config.params"
    system "echo bsd_games_cfg_gamesdir='#{CREW_PREFIX}/bin' >> config.params"
    system "echo bsd_games_cfg_sbindir='#{CREW_PREFIX}/sbin' >> config.params"
    system "echo bsd_games_cfg_usrbindir='#{CREW_PREFIX}/bin' >> config.params"
    system "echo bsd_games_cfg_libexecdir='#{CREW_PREFIX}/libexec' >> config.params"
    system "echo bsd_games_cfg_man6dir='#{CREW_MAN_PREFIX}/man6' >> config.params"
    system "echo bsd_games_cfg_man8dir='#{CREW_MAN_PREFIX}/man8' >> config.params"
    system "echo bsd_games_cfg_man5dir='#{CREW_MAN_PREFIX}/man5' >> config.params"
    system "echo bsd_games_cfg_do_chown='n' >> config.params" # Use chronos not root
    system "echo bsd_games_cfg_use_dot_so='symlinks' >> config.params"
    system "echo bsd_games_cfg_sharedir='#{CREW_PREFIX}/share/games' >> config.params"
    system "echo bsd_games_cfg_varlibdir='#{CREW_PREFIX}/var/games' >> config.params"
    system "echo bsd_games_cfg_ncurses_includes='-I#{CREW_PREFIX}/include/ncursesw' >> config.params"
    system "echo bsd_games_cfg_use_libcrypto='n' >> config.params"
    system "echo bsd_games_cfg_other_cflags='-flto' >> config.params" # Link-time optimization
    system "echo bsd_games_cfg_other_ldflags='-flto' >> config.params"
    system "echo bsd_games_cfg_pager='$(which less)' >> config.params" # Most looks weird and more doesn't scroll up
    system "echo bsd_games_cfg_dictionary_src='#{CREW_PREFIX}/share/dict/words' >> config.params"
    system "echo bsd_games_cfg_dm_configfile='#{CREW_PREFIX}/etc/dm/dm.conf' >> config.params"
    system "echo bsd_games_cfg_dm_nogamesfile='#{CREW_PREFIX}/etc/dm/nogames' >> config.params"
    system "echo bsd_games_cfg_hangman_wordsfile='#{CREW_PREFIX}/share/dict/words' >> config.params"
    system "echo bsd_games_cfg_wtf_acronymfile='#{CREW_PREFIX}/share/misc/acryonyms' >> config.params"
    system "echo bsd_games_cfg_cc='clang' >> config.params" # Didn't compile with gcc
    system "echo bsd_games_cfg_cxx='clang++' >> config.params"
    system "echo bsd_games_cfg_ncurses_lib='$(pkg-config --libs-only-l ncurses)' >> config.params" # Fix ncurses support
  end
  
  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    system "make", "check"
  end
end