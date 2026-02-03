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
    aarch64: 'f6e18c0c225f8bab2942851b34dfa380fd589fcdd9ca1c04f8dc796a05e96310',
     armv7l: 'f6e18c0c225f8bab2942851b34dfa380fd589fcdd9ca1c04f8dc796a05e96310',
       i686: 'e339e6f0cadf57a026f2860985317d6cfb1bb919e676f500805e75141325019f',
     x86_64: '4af0b7b94994ce2b48b065760ef9b6028e5b14efdf7f5bc344229082afa5f522'
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
