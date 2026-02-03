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
    aarch64: '63236d31520815b4ee8a0d8ec7a82b73b4d1184c948194eab05d60f64cd70e44',
     armv7l: '63236d31520815b4ee8a0d8ec7a82b73b4d1184c948194eab05d60f64cd70e44',
       i686: 'befe90114d3dd315aa9670e6ac22afcd85c6993f02deb12446f6d72ff278fdfe',
     x86_64: 'f0b3e5eb256233eef55875bff028010fb8f000a998f50652dd08aeddce5dcf7f'
  })

  depends_on 'glibc' # R
  depends_on 'zlib' # R

  no_lto

  # Much copied from https://salsa.debian.org/tcltk-team/tcl9.0/-/blob/master/debian/rules?ref_type=heads
  autotools_build_relative_dir 'unix'
  autotools_pre_configure_options "TCL_LIBRARY=#{CREW_LIB_PREFIX}/tcl#{version.rpartition('.')[0]} TCL_PACKAGE_PATH=#{CREW_LIB_PREFIX}/tcltk:#{CREW_PREFIX}/share/tcltk:#{CREW_LIB_PREFIX}/tcltk:#{CREW_PREFIX}share/tcltk:#{CREW_LIB_PREFIX}/tcltk/tcl#{version.rpartition('.')[0]}:#{CREW_LIB_PREFIX}"
  autotools_configure_options "--#{ARCH == 'x86_64' ? 'enable' : 'disable'}-64bit \
                               --includedir=#{CREW_PREFIX}/include/tcl#{version.rpartition('.')[0]} \
                               --enable-shared \
                               --enable-threads"

  autotools_install_extras do
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", "INSTALL_ROOT=#{CREW_DEST_DIR}", "MAN_INSTALL_DIR=#{CREW_DEST_MAN_PREFIX}", "TCL_MODULE_PATH=\"#{CREW_LIB_PREFIX}/tcltk #{CREW_PREFIX}/share/tcltk\"", 'install'
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", "INSTALL_ROOT=#{CREW_DEST_DIR}", "MAN_INSTALL_DIR=#{CREW_DEST_MAN_PREFIX}", "TCL_MODULE_PATH=\"#{CREW_LIB_PREFIX}/tcltk #{CREW_PREFIX}/share/tcltk\"", 'install-private-headers'
    FileUtils.ln_s "#{CREW_PREFIX}/bin/tclsh#{version.rpartition('.')[0]}", "#{CREW_DEST_PREFIX}/bin/tclsh"
  end
end
