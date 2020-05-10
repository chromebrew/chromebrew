require 'package'

class Xterm < Package
  description 'The xterm program is a terminal emulator for the X Window System.'
  homepage 'https://invisible-island.net/xterm/'
  version '341-1'
  compatibility 'all'
  source_url "https://invisible-mirror.net/archives/xterm/xterm-341.tgz"
  source_sha256 '63a07dfa2b5d501a9e1da0e05772bff7ad431ac2065127c77eebe392ef33cb44'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/xterm-341-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/xterm-341-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/xterm-341-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/xterm-341-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'b0c2289b1f2a2927d3bd133059705407e6418bc595a59aca522eaf9bd92e9e00',
     armv7l: 'b0c2289b1f2a2927d3bd133059705407e6418bc595a59aca522eaf9bd92e9e00',
       i686: '0803e8b84a900c5344bc2aa4f2586e8795bf6feb517bc7b75dae69c9438d5eef',
     x86_64: 'c93930b998ed21cccde94dc81c2aa5e0f91d986d9f193c4c61ca2714d10a8956',
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
