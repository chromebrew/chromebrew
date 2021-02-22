require 'package'

class Tk < Package
  description 'Tk is a graphical user interface toolkit that takes developing desktop applications to a higher level than conventional approaches.'
  homepage 'http://www.tcl.tk/'
  @_ver = '8.6.11'
  version @_ver
  compatibility 'all'
  source_url "https://downloads.sourceforge.net/project/tcl/Tcl/#{@_ver}/tk#{@_ver}-src.tar.gz"
  source_sha256 '5228a8187a7f70fa0791ef0f975270f068ba9557f57456f51eb02d9d4ea31282'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/tk-8.6.11-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/tk-8.6.11-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/tk-8.6.11-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/tk-8.6.11-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'a8866147a504c56cd834f71e078d6ca080f52873e673cbc55c7a7939991c6d3b',
     armv7l: 'a8866147a504c56cd834f71e078d6ca080f52873e673cbc55c7a7939991c6d3b',
       i686: '8a4afe834eaf7fb966714513becbde55e10125e1c3018e2db61aabb5565526fe',
     x86_64: 'dac36fa0385f8958676b71ee2dc10278fa7e5ebf7aa6ae3a3e04ea1b85fa9443'
  })

  depends_on 'xorg_lib'
  depends_on 'tcl'

  def self.build
    FileUtils.chdir('unix') do
      if ARCH == 'x86_64'
        system "env CFLAGS='-flto=auto -pipe -fuse-ld=gold' \
          CXXFLAGS='-flto=auto -pipe -fuse-ld=gold' \
          LDFLAGS='-flto=auto' \
          ./configure \
          --prefix=#{CREW_PREFIX} \
          --libdir=#{CREW_LIB_PREFIX} \
          --mandir=#{CREW_PREFIX}/share/man \
          --with-tcl=#{CREW_LIB_PREFIX} \
          --enable-threads \
          --enable-64bit"
      else
        system "env CFLAGS='-flto=auto -pipe -fuse-ld=gold' \
          CXXFLAGS='-flto=auto -pipe -fuse-ld=gold' \
          LDFLAGS='-flto=auto' \
          ./configure \
          --prefix=#{CREW_PREFIX} \
          --libdir=#{CREW_LIB_PREFIX} \
          --mandir=#{CREW_PREFIX}/share/man \
          --with-tcl=#{CREW_LIB_PREFIX} \
          --enable-threads \
          --disable-64bit"
      end
      system 'make'
    end
  end

  def self.install
    FileUtils.chdir('unix') do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
      FileUtils.ln_s "#{CREW_PREFIX}/bin/wish8.6", "#{CREW_DEST_PREFIX}/bin/wish"
    end
  end
end
