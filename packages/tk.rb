require 'package'

class Tk < Package
  description 'Tk is a graphical user interface toolkit that takes developing desktop applications to a higher level than conventional approaches.'
  homepage 'http://www.tcl.tk/'
  @_ver = '8.6.13'
  @_ver_prelastdot = @_ver.rpartition('.')[0]
  version @_ver
  license 'tcltk'
  compatibility 'all'
  source_url "https://downloads.sourceforge.net/project/tcl/Tcl/#{@_ver}/tk#{@_ver}-src.tar.gz"
  source_sha256 '2e65fa069a23365440a3c56c556b8673b5e32a283800d8d9b257e3f584ce0675'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tk/8.6.13_armv7l/tk-8.6.13-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tk/8.6.13_armv7l/tk-8.6.13-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tk/8.6.13_i686/tk-8.6.13-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tk/8.6.13_x86_64/tk-8.6.13-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '60828b2d3afe1123cffd6959045692ec51bd454f1206365295d75d06df9e1bcf',
     armv7l: '60828b2d3afe1123cffd6959045692ec51bd454f1206365295d75d06df9e1bcf',
       i686: 'f9e25e5d0d50ef16f84e4641cc62e49b509a97df0fac8d27d4d59a1b3c824b8c',
     x86_64: '03e96c918d55ef6ae6dc0b86af2cfc4c5732c799cf950efec089e4df7a4a7027'
  })

  depends_on 'freetype' # R
  depends_on 'glibc' # R
  depends_on 'harfbuzz' # R
  depends_on 'libx11' # R
  depends_on 'libxext' unless ARCH == 'i686' # R
  depends_on 'libxft' unless ARCH == 'i686' # R
  depends_on 'libxss' unless ARCH == 'i686' # R
  depends_on 'tcl' # R
  depends_on 'zlibpkg' # R

  no_env_options

  def self.build
    FileUtils.chdir('unix') do
      @bit64 = ARCH == 'x86_64' ? 'enable' : 'disable'
      system "#{CREW_ENV_FNO_LTO_OPTIONS} ./configure \
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
