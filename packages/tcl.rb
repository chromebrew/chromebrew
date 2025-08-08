require 'buildsystems/autotools'

class Tcl < Autotools
  description 'Tcl (Tool Command Language) is a very powerful but easy to learn dynamic programming language, suitable for a very wide range of uses, including web and desktop applications, networking, administration, testing and many more.'
  homepage 'http://www.tcl.tk/'
  version '9.0.2'
  license 'tcltk'
  compatibility 'all'
  source_url "https://downloads.sourceforge.net/project/tcl/Tcl/#{version}/tcl#{version}-src.tar.gz"
  source_sha256 'a72b1607d7a399c75148c80fcdead88ed3371a29884181f200f2200cdee33bbc'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6d3412b1ec0b21c762779f570ef0c37742d88713b11c7f746df25d1851812fef',
     armv7l: '6d3412b1ec0b21c762779f570ef0c37742d88713b11c7f746df25d1851812fef',
       i686: '25777f7257197eff3dbdf905cba347aa499c4dc55998c76dbed3c9ddb0a34c86',
     x86_64: '72f364a9202866f1a34a1a7390601ea6592f572911060d1dda4628807e56164f'
  })

  depends_on 'glibc' # R
  depends_on 'zlib' # R

  no_lto

  autotools_build_relative_dir 'unix'
  autotools_configure_options "--#{ARCH == 'x86_64' ? 'enable' : 'disable'}-64bit"

  autotools_install_extras do
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install-private-headers'
    FileUtils.ln_s "#{CREW_PREFIX}/bin/tclsh#{version.rpartition('.')[0]}", "#{CREW_DEST_PREFIX}/bin/tclsh"
  end
end
