require 'package'

class Tk < Package
  description 'Tk is a graphical user interface toolkit that takes developing desktop applications to a higher level than conventional approaches.'
  homepage 'http://www.tcl.tk/'
  @_ver = '8.6.12'
  @_ver_prelastdot = @_ver.rpartition('.')[0]
  version @_ver
  license 'tcltk'
  compatibility 'all'
  source_url "https://downloads.sourceforge.net/project/tcl/Tcl/#{@_ver}/tk#{@_ver}-src.tar.gz"
  source_sha256 '12395c1f3fcb6bed2938689f797ea3cdf41ed5cb6c4766eec8ac949560310630'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tk/8.6.11-1_armv7l/tk-8.6.11-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tk/8.6.11-1_armv7l/tk-8.6.11-1-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tk/8.6.11-1_i686/tk-8.6.11-1-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tk/8.6.11-1_x86_64/tk-8.6.11-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '45f352f6979be6011f5f1d4a8ee6caef842ae2d8579f2d3ae69bf361a41e320d',
     armv7l: '45f352f6979be6011f5f1d4a8ee6caef842ae2d8579f2d3ae69bf361a41e320d',
       i686: '13d38ebfee7bec6dc28f0785fed724d459b22e3dbf8e8f2c7483c05ee75e0c25',
     x86_64: '05b1753d45c1820ec8f51e28fe523376efaf04589b93bcefd38fc83752587390'
  })

  depends_on 'freetype' # R
  depends_on 'glibc' # R
  depends_on 'harfbuzz' # R
  depends_on 'libx11' # R
  depends_on 'libxext' # R
  depends_on 'libxft' # R
  depends_on 'libxss' # R
  depends_on 'tcl' # R
  depends_on 'zlibpkg' # R

  def self.build
    FileUtils.chdir('unix') do
      @bit64 = ARCH == 'x86_64' ? 'enable' : 'disable'
      system "./configure \
          #{CREW_OPTIONS} \
          --with-tcl=#{CREW_LIB_PREFIX} \
          --enable-threads \
          --#{@bit64}-64bit"
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
