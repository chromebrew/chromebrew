require 'buildsystems/autotools'

class Bsdgames < Autotools
  description 'A compilation of text-based games and programs from UNIX folklore.'
  homepage 'https://www.polyomino.org.uk/computer/software/bsd-games/'
  license 'BSD'
  @_ver = '2.17'
  @_debver = '34'
  version "#{@_ver}-debian#{@_debver}"
  compatibility 'all'
  source_url 'https://salsa.debian.org/games-team/bsdgames.git'
  git_hashtag "debian/#{@_ver}-#{@_debver}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '53bc9aadf8addd1de685e1d70ffa3dbf103e5220a5a86525a750d33d229f6f3e',
     armv7l: '53bc9aadf8addd1de685e1d70ffa3dbf103e5220a5a86525a750d33d229f6f3e',
       i686: '1d4dbfbfe1793eb67c9cf6549c980865f2bd24135d1fce4cd993f5564c98ff67',
     x86_64: '914a487539eb730919d364409650d4e49f4f0e50541cacf3a89f44feda269ca3'
  })

  depends_on 'flex' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'miscfiles' # L
  depends_on 'ncurses' # R
  depends_on 'words' # L

  run_tests

  def self.patch
    puts 'Downloading additional patches...'.lightblue
    Dir.chdir 'debian/patches' do
      downloader 'https://raw.github.com/gentoo/gentoo/ac439edc59f851483ecb9f732f9e5c65aa057224/games-misc/bsd-games/files/bsd-games-2.17-64bitutmp.patch', '992f8602661cc41c3253317bfc157abe0b2041cd7d32f5a31811708e2f8c4e23'
      downloader 'https://raw.github.com/gentoo/gentoo/ac439edc59f851483ecb9f732f9e5c65aa057224/games-misc/bsd-games/files/bsd-games-2.17-bg.patch', 'd25eb2b0e6790b6a852bce08f384994fed7b37a9d33d12d01b65e67fbd8f67d7'
      downloader 'https://raw.github.com/gentoo/gentoo/ac439edc59f851483ecb9f732f9e5c65aa057224/games-misc/bsd-games/files/bsd-games-2.17-gcc4.patch', '96639f25206401c0dde3f9f28ac287c9e26c3efb526481fa48b482f8c9ab4ac0'
    end
    puts 'Patching...'.lightblue
    system "sed -i '/0006-Custom-configuration-of-Debian-package-build.patch/d' debian/patches/series" # Don't need the debian custom config.
    system "for i in \$(cat debian/patches/series); do patch -Np1 -i debian/patches/\"\${i}\"; done"
    system "sed -i 's:-lncurses:-lncurses -ltinfo:g' configure" # Add libtinfo support
    system "sed -i 's:-lcrypto:-lssl -lcrypto:g' configure" # Fix openssl
    system "sed -i 's:#!/bin/sh:#!/bin/bash:' configure" # dash doesn't work
    system "sed -i 's:read input:read -t 0.1 input:' configure" # Make script automatic
    # As per https://aur.archlinux.org/cgit/aur.git/tree/hunt-sigpause.diff?h=bsd-games2
    system "sed -i '/sigpause/d' hunt/hunt/otto.c"
    system "sed -i 's:-O2:-O3:g' configure"
    system "sed -i 's:/usr/games:#{CREW_PREFIX}/bin:' wargames/wargames"
    File.write 'config_params', <<~EOF
      bsd_games_cfg_build_dirs="adventure arithmetic atc backgammon banner battlestar bcd \
                boggle caesar canfield countmail cribbage dab fish gomoku \
                hangman hunt mille monop morse number phantasia pig pom ppt \
                primes quiz rain random robots sail snake tetris trek wargames \
                worm worms wtf wump"
      bsd_games_cfg_cc='\"#{CREW_TARGET}-gcc\"'
      bsd_games_cfg_cxx='\"#{CREW_TARGET}-g++\"'
      bsd_games_cfg_dictionary_src='#{CREW_PREFIX}/share/dict/words'
      bsd_games_cfg_dm_configfile='#{CREW_PREFIX}/etc/dm/dm.conf'
      bsd_games_cfg_dm_nogamesfile='#{CREW_PREFIX}/etc/dm/nogames'
      bsd_games_cfg_docdir='#{CREW_PREFIX}/share/doc/bsdgames'
      bsd_games_cfg_do_chown=n
      bsd_games_cfg_gamesdir='#{CREW_PREFIX}/bin'
      bsd_games_cfg_hangman_wordsfile='#{CREW_PREFIX}/share/dict/words'
      bsd_games_cfg_install_prefix=#{CREW_DEST_DIR}
      bsd_games_cfg_libexecdir='#{CREW_PREFIX}/libexec'
      bsd_games_cfg_man5dir='#{CREW_MAN_PREFIX}/man5'
      bsd_games_cfg_man6dir='#{CREW_MAN_PREFIX}/man6'
      bsd_games_cfg_man8dir='#{CREW_MAN_PREFIX}/man8'
      bsd_games_cfg_ncurses_includes='#{`pkg-config --cflags-only-I ncurses`.chomp}'
      bsd_games_cfg_ncurses_lib='#{`pkg-config --libs-only-l ncurses`.chomp}'
      bsd_games_cfg_non_interactive=y
      bsd_games_cfg_other_ldflags='\"#{CREW_LDFLAGS}\"'
      bsd_games_cfg_pager='#{CREW_PREFIX}/bin/#{ENV.fetch('PAGER', nil)}'
      bsd_games_cfg_sbindir='#{CREW_PREFIX}/sbin'
      bsd_games_cfg_sharedir='#{CREW_PREFIX}/share/bsdgames'
      bsd_games_cfg_gzip_manpages=n
      bsd_games_cfg_use_dot_so=.so
      bsd_games_cfg_use_libcrypto=n
      bsd_games_cfg_usrbindir='#{CREW_PREFIX}/bin'
      bsd_games_cfg_varlibdir='#{CREW_PREFIX}/var/bsdgames'
      bsd_games_cfg_wtf_acronymfile='#{CREW_PREFIX}/share/misc/acronyms'
    EOF
  end
end
