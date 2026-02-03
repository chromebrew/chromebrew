require 'buildsystems/autotools'

class Tcl < Autotools
  description 'Tcl (Tool Command Language) is a very powerful but easy to learn dynamic programming language, suitable for a very wide range of uses, including web and desktop applications, networking, administration, testing and many more.'
  homepage 'http://www.tcl.tk/'
  version '9.0.3-1'
  license 'tcltk'
  compatibility 'all'
  source_url "https://downloads.sourceforge.net/project/tcl/Tcl/#{version.split('-').first}/tcl#{version.split('-').first}-src.tar.gz"
  source_sha256 '2537ba0c86112c8c953f7c09d33f134dd45c0fb3a71f2d7f7691fd301d2c33a6'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f1f71b09a1754108f3c6c5d86cc84cc936883b8ab1a75456cad01e80a5db895b',
     armv7l: 'f1f71b09a1754108f3c6c5d86cc84cc936883b8ab1a75456cad01e80a5db895b',
       i686: '194cbd3ea4c4999528a14cf7be63f1d675ef10680250520d7e7a2005ed497a97',
     x86_64: 'a1d48a1e41625fd1a865153ccf6f64e9c60bcbaf147dc8c1e2365b193bb20a11'
  })

  depends_on 'glibc' # R
  depends_on 'zlib' # R

  no_lto

  def self.patch
    # As in https://salsa.debian.org/tcltk-team/tcl9.0/-/blob/master/debian/rules?ref_type=heads
    FileUtils.touch 'generic/tclStubInit.c'
  end

  # Much copied from https://salsa.debian.org/tcltk-team/tcl9.0/-/blob/master/debian/rules?ref_type=heads
  autotools_build_relative_dir 'unix'
  autotools_pre_configure_options "TCL_LIBRARY=#{CREW_LIB_PREFIX}/tcl#{version.rpartition('.')[0]} TCL_PACKAGE_PATH=#{CREW_LIB_PREFIX}/tcltk:#{CREW_PREFIX}/share/tcltk:#{CREW_LIB_PREFIX}/tcltk:#{CREW_PREFIX}share/tcltk:#{CREW_LIB_PREFIX}/tcltk/tcl#{version.rpartition('.')[0]}:#{CREW_LIB_PREFIX}"
  autotools_configure_options "--#{ARCH == 'x86_64' ? 'enable' : 'disable'}-64bit \
                               --disable-zipfs \
                               --enable-shared \
                               --enable-threads \
                               --includedir=#{CREW_PREFIX}/include/tcl#{version.rpartition('.')[0]}"

  autotools_install_options "INSTALL_ROOT=#{CREW_DEST_DIR} MAN_INSTALL_DIR=#{CREW_DEST_MAN_PREFIX} TCL_MODULE_PATH=\"#{CREW_LIB_PREFIX}/tcltk #{CREW_PREFIX}/share/tcltk\""
  autotools_install_extras do
    system "make #{@autotools_install_options} install-private-headers"
    FileUtils.ln_s "#{CREW_PREFIX}/bin/tclsh#{version.rpartition('.')[0]}", "#{CREW_DEST_PREFIX}/bin/tclsh"
  end
end
