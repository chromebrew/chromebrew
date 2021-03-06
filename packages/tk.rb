require 'package'

class Tk < Package
  description 'Tk is a graphical user interface toolkit that takes developing desktop applications to a higher level than conventional approaches.'
  homepage 'http://www.tcl.tk/'
  @_ver = '8.6.11'
  @_ver_prelastdot = @_ver.rpartition('.')[0]
  version "#{@_ver}-1"
  compatibility 'all'
  source_url "https://downloads.sourceforge.net/project/tcl/Tcl/#{@_ver}/tk#{@_ver}-src.tar.gz"
  source_sha256 '5228a8187a7f70fa0791ef0f975270f068ba9557f57456f51eb02d9d4ea31282'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/tk-8.6.11-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/tk-8.6.11-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/tk-8.6.11-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/tk-8.6.11-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '45f352f6979be6011f5f1d4a8ee6caef842ae2d8579f2d3ae69bf361a41e320d',
     armv7l: '45f352f6979be6011f5f1d4a8ee6caef842ae2d8579f2d3ae69bf361a41e320d',
       i686: '13d38ebfee7bec6dc28f0785fed724d459b22e3dbf8e8f2c7483c05ee75e0c25',
     x86_64: '05b1753d45c1820ec8f51e28fe523376efaf04589b93bcefd38fc83752587390'
  })

  depends_on 'xorg_lib'
  depends_on 'tcl'

  def self.build
    FileUtils.chdir('unix') do
      if ARCH == 'x86_64'
        system "env CFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      CXXFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      LDFLAGS='-fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
          ./configure \
          #{CREW_OPTIONS} \
          --with-tcl=#{CREW_LIB_PREFIX} \
          --enable-threads \
          --enable-64bit"
      else
        system "env CFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      CXXFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      LDFLAGS='-fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
          ./configure \
          #{CREW_OPTIONS} \
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
      FileUtils.ln_s "#{CREW_PREFIX}/bin/wish#{@_ver_prelastdot}", "#{CREW_DEST_PREFIX}/bin/wish"
    end
  end
end
