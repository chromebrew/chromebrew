require 'package'

class Tk < Package
  description 'Tk is a graphical user interface toolkit that takes developing desktop applications to a higher level than conventional approaches.'
  homepage 'http://www.tcl.tk/'
  version '8.6.14'
  license 'tcltk'
  compatibility 'x86_64 aarch64 armv7l'
  source_url "https://downloads.sourceforge.net/project/tcl/Tcl/#{version}/tk#{version}-src.tar.gz"
  source_sha256 '8ffdb720f47a6ca6107eac2dd877e30b0ef7fac14f3a84ebbd0b3612cee41a94'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '039a2b1b70f4eaaef0d7e53339e40d0ad0c3f76b271eb4c2df399b39571cd6ef',
     armv7l: '039a2b1b70f4eaaef0d7e53339e40d0ad0c3f76b271eb4c2df399b39571cd6ef',
     x86_64: '3c36ce7b693d7f46df30abfdae507dc4b85de846bdcaf0629dedba835830423d'
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
      FileUtils.ln_s "#{CREW_PREFIX}/bin/wish#{version.rpartition('.')[0]}", "#{CREW_DEST_PREFIX}/bin/wish"
    end
  end
end
