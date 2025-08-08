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
    aarch64: '25089d352087c5ef499a2eb9f850bfe4040492e0bbe61c11e2a37e136c0f60cf',
     armv7l: '25089d352087c5ef499a2eb9f850bfe4040492e0bbe61c11e2a37e136c0f60cf',
       i686: 'e12cd39031f48be9bcc3c3c2b6377015265016aa8c62d218a849cc40ed77cd9f',
     x86_64: 'deb976d3af98c85d1a8a376beb8e1985c5883ff868d3dda618ef238c485ba42f'
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
