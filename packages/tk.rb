require 'package'

class Tk < Package
  description 'Tk is a graphical user interface toolkit that takes developing desktop applications to a higher level than conventional approaches.'
  homepage 'http://www.tcl.tk/'
  @_ver = '8.6.13'
  version '8.6.13-1'
  license 'tcltk'
  compatibility 'x86_64 aarch64 armv7l'
  source_url "https://downloads.sourceforge.net/project/tcl/Tcl/#{@_ver}/tk#{@_ver}-src.tar.gz"
  source_sha256 '2e65fa069a23365440a3c56c556b8673b5e32a283800d8d9b257e3f584ce0675'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '11d5f652674f27e7b74b21c2cc1a5132fe068f42d9959e8f39b687b9cc4ba5ae',
     armv7l: '11d5f652674f27e7b74b21c2cc1a5132fe068f42d9959e8f39b687b9cc4ba5ae',
     x86_64: '1972370b1bfb3fa2ae2f2881e319e92f1fb6eb2a2245445f92fe78456874fdb6'
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

  no_lto

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
      FileUtils.ln_s "#{CREW_PREFIX}/bin/wish#{@_ver.rpartition('.')[0]}", "#{CREW_DEST_PREFIX}/bin/wish"
    end
  end
end
