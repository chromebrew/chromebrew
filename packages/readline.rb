require 'package'

class Readline < Package
  description 'The GNU Readline library provides a set of functions for use by applications that allow users to edit command lines as they are typed in.'
  homepage 'http://cnswww.cns.cwru.edu/php/chet/readline/rltop.html'
  @_ver = '8.1'
  version "#{@_ver}-1"
  compatibility 'all'
  source_url "https://gnu.askapache.com/readline/readline-#{@_ver}.tar.gz"
  source_sha256 'f8ceb4ee131e3232226a17f51b164afc46cd0b9e6cef344be87c65962cb82b02'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/readline-8.1-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/readline-8.1-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/readline-8.1-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/readline-8.1-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '59a46fc3edcb1a6dd5039aee1e7dda31289e87f60c8d260f8f883da11880425e',
     armv7l: '59a46fc3edcb1a6dd5039aee1e7dda31289e87f60c8d260f8f883da11880425e',
       i686: '5ceea6d03304fdbd8cd1a1a999831bafe46938f458128c0bc5df1a6819114201',
     x86_64: '3d60b7fd04b57c4b57b34d8af12ab7b7dbf368842fc8b19b09df7698e9623292'
  })

  def self.build
    system "env CFLAGS='-flto=auto -g0' \
      CXXFLAGS='-flto=auto' \
      LDFLAGS='-flto=auto' \
      ./configure \
      #{CREW_OPTIONS} \
      --with-curses \
      --enable-multibyte"
    system 'make', 'SHLIB_LIBS=-Wl,--as-needed -Wl,-ltinfow -Wl,--no-as-needed'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
