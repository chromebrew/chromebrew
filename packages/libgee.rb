require 'package'

class Libgee < Package
  description 'Libgee is an utility library providing GObject-based interfaces and classes for commonly used data structures.'
  homepage 'https://wiki.gnome.org/Projects/Libgee'
  @_ver = '0.20.4'
  @_ver_prelastdot = @_ver.rpartition('.')[0]
  version @_ver
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url "https://gitlab.gnome.org/GNOME/libgee/-/archive/#{@_ver}/libgee-#{@_ver}.tar.bz2"
  source_sha256 'bf1e5840809e34e07b253e1363ec58c8844dac7400bc75c450e1c7aa13019c51'

  binary_url({
    aarch64: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/libgee-0.20.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/libgee-0.20.4-chromeos-armv7l.tar.xz',
       i686: 'https://downloads.sourceforge.net/project/chromebrew/i686/libgee-0.20.4-chromeos-i686.tar.xz',
     x86_64: 'https://downloads.sourceforge.net/project/chromebrew/x86_64/libgee-0.20.4-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'f15038fd3c894a96872bedeac5fc922bbf204900139fbf0bdad9edc42166910d',
     armv7l: 'f15038fd3c894a96872bedeac5fc922bbf204900139fbf0bdad9edc42166910d',
       i686: 'eee9240a4dca8afd2393ed595384fbaef98e83a6a0e6ce8f86290265d6f62025',
     x86_64: '6fbb91042ade5d1fe01e47e87599a883e75f7b7d26304b0e4788684de47f8993'
  })

  def self.build
    system '[ -x configure ] || NOCONFIGURE=1 ./autogen.sh'
    system "env CFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      CXXFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      LDFLAGS='-fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.check
    system 'make', 'check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
