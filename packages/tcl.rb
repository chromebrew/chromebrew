require 'buildsystems/autotools'

class Tcl < Autotools
  description 'Tcl (Tool Command Language) is a very powerful but easy to learn dynamic programming language, suitable for a very wide range of uses, including web and desktop applications, networking, administration, testing and many more.'
  homepage 'http://www.tcl.tk/'
  version '9.0.4'
  license 'tcltk'
  compatibility 'all'
  source_url "https://downloads.sourceforge.net/project/tcl/Tcl/#{version}/tcl#{version}-src.tar.gz"
  source_sha256 'd0aed49230bc02a65c1e0229e65f34590a4b037ec40d546f32573b467f7551ea'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6724e87c237b45e092561b339d17d11fd33b626adb17f17a50d64210c0433bbc',
     armv7l: '6724e87c237b45e092561b339d17d11fd33b626adb17f17a50d64210c0433bbc',
       i686: '68c36e34a0a3a2120d6704eca6f5abcfe146a10f372e2b32862f080efc60aacf',
     x86_64: 'faf0db65f7d11e847e6bf10ed34527c594f35a3ac416048d36cff54b7db96c7a'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'zlib' => :library

  no_lto

  # To fix error while loading shared libraries: libtcl9.0.so: cannot open shared object file: No such file or directory,
  # install tcl prior to attempting to build.

  def self.patch
    # As in https://salsa.debian.org/tcltk-team/tcl9.0/-/blob/master/debian/rules?ref_type=heads
    FileUtils.touch 'generic/tclStubInit.c'
  end

  # Much copied from https://salsa.debian.org/tcltk-team/tcl9.0/-/blob/master/debian/rules?ref_type=heads
  # --disable-zipfs needed for init.tcl
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
