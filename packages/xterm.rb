require 'package'

class Xterm < Package
  description 'The xterm program is a terminal emulator for the X Window System.'
  homepage 'https://invisible-island.net/xterm/'
  version '362'
  compatibility 'all'
  source_url "https://invisible-mirror.net/archives/xterm/xterm-362.tgz"
  source_sha256 '1d4ffe226fa8f021859bbc3007788ff63a46a31242d9bd9a7bd7ebe24e81aca2'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/xterm-362-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/xterm-362-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/xterm-362-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/xterm-362-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'e61f8a1bfc06e700ec42b0d3f7e97b9b1e0f8120a33fbfc6efeba3eabda24126',
     armv7l: 'e61f8a1bfc06e700ec42b0d3f7e97b9b1e0f8120a33fbfc6efeba3eabda24126',
       i686: '7912500763cca0d85c1f6d84ec4cce6cbd5b4c9a70090dfe49cc94a395b7b84b',
     x86_64: 'c6dd0a0eebbe9a84af571c79ad1ecb925b1a16333bb6e75280f5818c86faedb5',
  })

  depends_on 'pcre'
  depends_on 'sommelier'

  def self.build
    system './configure',
           '--with-x',
           '--with-pcre',
           '--with-xinerama',
           '--enable-dabbrev',
           '--enable-toolbar',
           '--with-pkg-config',
           '--enable-exec-xterm',
           '--enable-16bit-chars',
           '--enable-dec-locator',
           '--enable-double-buffer',
           '--enable-readline-mouse',
           '--enable-regis-graphics',
           '--enable-sixel-graphics',
           "--prefix=#{CREW_PREFIX}",
           "--with-xpm=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system "make install DESTDIR=#{CREW_DEST_DIR}"
    system "make install-ti DESTDIR=#{CREW_DEST_DIR}"
  end
end
