require 'package'

class Bsdgame < Package
  $_bsdgame_homepage = 'https://www.polyomino.org.uk/computer/software/bsd-games/'
  @_ver = '2.17'
  @_debver = '28'
  $_bsdgame_version = @_ver + '-debian' + @_debver
  $_bsdgame_source_url = 'https://salsa.debian.org/games-team/bsdgames.git'
  $_bsdgame_git_hashtag = 'debian/' + @_ver + '-' + @_debver

  def self.bsdgame (gametobuild = nil)
    if gametobuild
      @bsdgame = gametobuild
    end
    @bsdgame
  end

  def self.patch
    puts 'Downloading patches'.lightblue
    Dir.chdir 'debian/patches' do
      system "curl -#LO https://raw.github.com/gentoo/gentoo/ac439edc59f851483ecb9f732f9e5c65aa057224/games-misc/bsd-games/files/bsd-games-2.17-64bitutmp.patch"
      system "curl -#LO https://raw.github.com/gentoo/gentoo/ac439edc59f851483ecb9f732f9e5c65aa057224/games-misc/bsd-games/files/bsd-games-2.17-bg.patch"
      system "curl -#LO https://raw.github.com/gentoo/gentoo/ac439edc59f851483ecb9f732f9e5c65aa057224/games-misc/bsd-games/files/bsd-games-2.17-gcc4.patch"
      # Verify patches
      puts 'Verifying patches'.lightblue
      @sha256sums = <<~EOF
        992f8602661cc41c3253317bfc157abe0b2041cd7d32f5a31811708e2f8c4e23  bsd-games-2.17-64bitutmp.patch
        d25eb2b0e6790b6a852bce08f384994fed7b37a9d33d12d01b65e67fbd8f67d7  bsd-games-2.17-bg.patch
        96639f25206401c0dde3f9f28ac287c9e26c3efb526481fa48b482f8c9ab4ac0  bsd-games-2.17-gcc4.patch
      EOF
      IO.write("sha256sums", @sha256sums)
      system "sha256sum -c sha256sums"
    end
    FileUtils.rm 'debian/patches/0006-Custom-configuration-of-Debian-package-build.patch' # Includes dpkg stuff
    system "for i in \$(cat debian/patches/series); do patch -Np1 -i debian/patches/\"\${i}\"; done"
    system "sed -i 's:-lncurses:-lncurses -ltinfo:g' configure" # Add libtinfo support
    system "sed -i 's:-lcrypto:-lssl -lcrypto:g' configure" # Fix openssl
    system "sed -i 's:#!/bin/sh:#!/bin/bash:' configure" # dash doesn't work
    system "sed -i 's:read input:read -t 0.2 input:' configure" # Make script automatic
  end

  def self.prebuild
    puts 'Configuring'.lightblue
    system "sed -i 's:-g -O2:#{CREW_COMMON_FLAGS}:g' configure"
    system "sed -i 's:/usr/games:#{CREW_PREFIX}/bin:' wargames/wargames"
    system "echo bsd_games_cfg_build_dirs='\"#{@bsdgame}\"' >> config.params"
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
    system "echo bsd_games_cfg_sharedir='#{CREW_PREFIX}/share/bsdgames' >> config.params"
    system "echo bsd_games_cfg_varlibdir='#{CREW_PREFIX}/var/bsdgames' >> config.params"
    system "echo bsd_games_cfg_ncurses_includes='-I#{CREW_PREFIX}/include/ncursesw' >> config.params"
    system "echo bsd_games_cfg_use_libcrypto='n' >> config.params"
    system "echo bsd_games_cfg_other_cflags='\"#{CREW_COMMON_FLAGS}\"' >> config.params" # Link-time optimization
    system "echo bsd_games_cfg_other_ldflags='\"#{CREW_LDFLAGS}\"' >> config.params"
    system "echo bsd_games_cfg_pager='$(which less)' >> config.params" # Most looks weird and more doesn't scroll up
    system "echo bsd_games_cfg_dictionary_src='#{CREW_PREFIX}/share/dict/words' >> config.params"
    system "echo bsd_games_cfg_dm_configfile='#{CREW_PREFIX}/etc/dm/dm.conf' >> config.params"
    system "echo bsd_games_cfg_dm_nogamesfile='#{CREW_PREFIX}/etc/dm/nogames' >> config.params"
    system "echo bsd_games_cfg_hangman_wordsfile='#{CREW_PREFIX}/share/dict/words' >> config.params"
    system "echo bsd_games_cfg_wtf_acronymfile='#{CREW_PREFIX}/share/misc/acryonyms' >> config.params"
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
