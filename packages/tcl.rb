require 'buildsystems/autotools'

class Tcl < Autotools
  description 'Tcl (Tool Command Language) is a very powerful but easy to learn dynamic programming language, suitable for a very wide range of uses, including web and desktop applications, networking, administration, testing and many more.'
  homepage 'http://www.tcl.tk/'
  version '9.1.0'
  license 'tcltk'
  compatibility 'all'
  source_url "https://downloads.sourceforge.net/project/tcl/Tcl/#{version}/tcl#{version}-src.tar.gz"
  source_sha256 '536c45543f64d6eb11832d97ba3494aacff046fbc5040273bd55258d0e448ff1'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f6fde2913cdcb523baba42aa4e9cc6b441e902c22686f98c27439cff20f99e90',
     armv7l: 'f6fde2913cdcb523baba42aa4e9cc6b441e902c22686f98c27439cff20f99e90',
       i686: 'bd5a7ab6f6694d0f6a5c1c264bbc57522ad4bcc2cdd3754064bce37c1101e001',
     x86_64: '17646fc25caa74e3ddd8cabe3a1d1b34b4a49b1693a8f55aae15e6a1698c430a'
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
