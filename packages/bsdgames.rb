require 'package'

class Bsdgames < Package
  description 'A compilation of text-based games and programs from UNIX folklore.'
  homepage 'https://www.polyomino.org.uk/computer/software/bsd-games/'
  @_ver = '2.17'
  @_debver = '28'
  version @_ver + '-debian' + @_debver
  compatibility 'all'
  source_url 'https://salsa.debian.org/games-team/bsdgames.git'
  git_hashtag 'debian/' + @_ver + '-' + @_debver

  depends_on 'words'
  depends_on 'miscfiles'

  @bsdgames = 'adventure arithmetic atc backgammon banner battlestar bcd \
              boggle caesar canfield countmail cribbage dab fish gomoku \
              hangman hunt mille monop morse number phantasia pig pom ppt \
              primes quiz rain random robots sail snake tetris trek wargames \
              worm worms wtf wump'

  def self.patch
    puts 'Downloading patches'.lightblue
    Dir.chdir 'debian/patches' do
      system 'curl -#LO https://raw.github.com/gentoo/gentoo/ac439edc59f851483ecb9f732f9e5c65aa057224/games-misc/bsd-games/files/bsd-games-2.17-64bitutmp.patch'
      system 'curl -#LO https://raw.github.com/gentoo/gentoo/ac439edc59f851483ecb9f732f9e5c65aa057224/games-misc/bsd-games/files/bsd-games-2.17-bg.patch'
      system 'curl -#LO https://raw.github.com/gentoo/gentoo/ac439edc59f851483ecb9f732f9e5c65aa057224/games-misc/bsd-games/files/bsd-games-2.17-gcc4.patch'
      # Verify patches
      puts 'Verifying patches'.lightblue
      @sha256sums = <<~EOF
        992f8602661cc41c3253317bfc157abe0b2041cd7d32f5a31811708e2f8c4e23  bsd-games-2.17-64bitutmp.patch
        d25eb2b0e6790b6a852bce08f384994fed7b37a9d33d12d01b65e67fbd8f67d7  bsd-games-2.17-bg.patch
        96639f25206401c0dde3f9f28ac287c9e26c3efb526481fa48b482f8c9ab4ac0  bsd-games-2.17-gcc4.patch
      EOF
      IO.write('sha256sums', @sha256sums)
      system 'sha256sum -c sha256sums'
    end
    FileUtils.rm 'debian/patches/0006-Custom-configuration-of-Debian-package-build.patch' # Includes dpkg stuff
    system "for i in \$(cat debian/patches/series); do patch -Np1 -i debian/patches/\"\${i}\"; done"
    system "sed -i 's:-lncurses:-lncurses -ltinfo:g' configure" # Add libtinfo support
    system "sed -i 's:-lcrypto:-lssl -lcrypto:g' configure" # Fix openssl
    system "sed -i 's:#!/bin/sh:#!/bin/bash:' configure" # dash doesn't work
    system "sed -i 's:read input:read -t 0.1 input:' configure" # Make script automatic
  end

  def self.prebuild
    puts 'Configuring'.lightblue
    system "sed -i 's:-g -O2::g' configure"
    system "sed -i 's:/usr/games:#{CREW_PREFIX}/bin:' wargames/wargames"
    system "echo bsd_games_cfg_build_dirs='\"#{@bsdgames}\"' | tee -a config.params"
    system "echo bsd_games_cfg_docdir='#{CREW_PREFIX}/share/doc/bsdgames' | tee -a config.params"
    system "echo bsd_games_cfg_install_prefix='#{CREW_DEST_DIR}' | tee -a config.params"
    system "echo bsd_games_cfg_gamesdir='#{CREW_PREFIX}/bin' | tee -a config.params"
    system "echo bsd_games_cfg_sbindir='#{CREW_PREFIX}/sbin' | tee -a config.params"
    system "echo bsd_games_cfg_usrbindir='#{CREW_PREFIX}/bin' | tee -a config.params"
    system "echo bsd_games_cfg_libexecdir='#{CREW_PREFIX}/libexec' | tee -a config.params"
    system "echo bsd_games_cfg_sharedir='#{CREW_PREFIX}/share/bsdgames' | tee -a config.params"
    system "echo bsd_games_cfg_man6dir='#{CREW_MAN_PREFIX}/man6' | tee -a config.params"
    system "echo bsd_games_cfg_man8dir='#{CREW_MAN_PREFIX}/man8' | tee -a config.params"
    system "echo bsd_games_cfg_man5dir='#{CREW_MAN_PREFIX}/man5' | tee -a config.params"
    system "echo bsd_games_cfg_varlibdir='#{CREW_PREFIX}/var/bsdgames' | tee -a config.params"
    system "echo bsd_games_cfg_do_chown='n' | tee -a config.params" # Use chronos not root
    system "echo bsd_games_cfg_use_dot_so='symlinks' | tee -a config.params"
    system "echo bsd_games_cfg_ncurses_includes='-I#{CREW_PREFIX}/include/ncursesw' | tee -a config.params"
    system "echo bsd_games_cfg_use_libcrypto='n' | tee -a config.params"
    system "echo bsd_games_cfg_cc='\"#{CREW_TGT}-gcc\"' | tee -a config.params"
    system "echo bsd_games_cfg_cxx='\"#{CREW_TGT}-g++\"' | tee -a config.params"
    system "echo bsd_games_cfg_other_cflags='\"#{CREW_COMMON_FLAGS}\"' | tee -a config.params" # Link-time optimization
    system "echo bsd_games_cfg_other_ldflags='\"#{CREW_LDFLAGS}\"' | tee -a config.params"
    system "echo bsd_games_cfg_pager='$(which less)' | tee -a config.params" # Most looks weird and more doesn't scroll up
    system "echo bsd_games_cfg_dictionary_src='#{CREW_PREFIX}/share/dict/words' | tee -a config.params"
    system "echo bsd_games_cfg_dm_configfile='#{CREW_PREFIX}/etc/dm/dm.conf' | tee -a config.params"
    system "echo bsd_games_cfg_dm_nogamesfile='#{CREW_PREFIX}/etc/dm/nogames' | tee -a config.params"
    system "echo bsd_games_cfg_hangman_wordsfile='#{CREW_PREFIX}/share/dict/words' | tee -a config.params"
    system "echo bsd_games_cfg_wtf_acronymfile='#{CREW_PREFIX}/share/misc/acryonyms' | tee -a config.params"
    system "echo bsd_games_cfg_ncurses_lib='$(pkg-config --libs-only-l ncurses)' | tee -a config.params" # Fix ncurses support
  end

  def self.build
    system './configure'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system 'make', 'check'
  end
end
