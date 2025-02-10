require 'package'

class Tk < Package
  description 'Tk is a graphical user interface toolkit that takes developing desktop applications to a higher level than conventional approaches.'
  homepage 'http://www.tcl.tk/'
  version '8.6.16'
  license 'tcltk'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://downloads.sourceforge.net/project/tcl/Tcl/#{version}/tk#{version}-src.tar.gz"
  source_sha256 '8ffdb720f47a6ca6107eac2dd877e30b0ef7fac14f3a84ebbd0b3612cee41a94'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '82a08a00077dcc0a758cb3d4eafe03a145185fb5d4e855787e08b7c1487af73a',
     armv7l: '82a08a00077dcc0a758cb3d4eafe03a145185fb5d4e855787e08b7c1487af73a',
     x86_64: '8623e92dc19caa784f90727744ac98f9a87fe1868f4a5d513b94a496bab177ab'
  })

  depends_on 'freetype' # R
  depends_on 'glibc' # R
  depends_on 'harfbuzz' # R
  depends_on 'libx11' # R
  depends_on 'libxext' # R
  depends_on 'libxft' # R
  depends_on 'libxss' # R
  depends_on 'tcl' # R
  depends_on 'zlib' # R

  no_lto

  def self.build
    FileUtils.chdir('unix') do
      @bit64 = ARCH == 'x86_64' ? 'enable' : 'disable'
      system "./configure \
          #{CREW_CONFIGURE_OPTIONS} \
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
