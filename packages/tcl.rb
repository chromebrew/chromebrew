require 'buildsystems/autotools'

class Tcl < Autotools
  description 'Tcl (Tool Command Language) is a very powerful but easy to learn dynamic programming language, suitable for a very wide range of uses, including web and desktop applications, networking, administration, testing and many more.'
  homepage 'http://www.tcl.tk/'
  version '9.0.1'
  license 'tcltk'
  compatibility 'all'
  source_url "https://downloads.sourceforge.net/project/tcl/Tcl/#{version}/tcl#{version}-src.tar.gz"
  source_sha256 'a72b1607d7a399c75148c80fcdead88ed3371a29884181f200f2200cdee33bbc'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '954698397c18fe344dacf6033939837f58dc069852994431e55fd4c2af079687',
     armv7l: '954698397c18fe344dacf6033939837f58dc069852994431e55fd4c2af079687',
       i686: '92f3ee73dd486d29ec9855b30074cb620ac46f178c31d8f5c56b877bf1515f9e',
     x86_64: '6fac769e898db52d2602b701d155fbf8e9b045894f34bfadadef30af37a57dea'
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
