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
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tk/8.6.12_armv7l/tk-8.6.12-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tk/8.6.12_armv7l/tk-8.6.12-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tk/8.6.12_i686/tk-8.6.12-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tk/8.6.12_x86_64/tk-8.6.12-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '286a469693791ce624b499e0770b72aebc33748c0e2e991608124d22416e8257',
     armv7l: '286a469693791ce624b499e0770b72aebc33748c0e2e991608124d22416e8257',
       i686: '388a87aa2d49248fcb10c1d51a16a3a09e77980e3400d7c683d6a9993f76568d',
     x86_64: '6c7df4328c26a2573c07d34f6047633dcbca88406d01d732cdf9ec9082b83f5b'
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
