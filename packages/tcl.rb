require 'buildsystems/autotools'

class Tcl < Autotools
  description 'Tcl (Tool Command Language) is a very powerful but easy to learn dynamic programming language, suitable for a very wide range of uses, including web and desktop applications, networking, administration, testing and many more.'
  homepage 'http://www.tcl.tk/'
  version '9.0.3'
  license 'tcltk'
  compatibility 'all'
  source_url "https://downloads.sourceforge.net/project/tcl/Tcl/#{version}/tcl#{version}-src.tar.gz"
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

  autotools_build_relative_dir 'unix'
  autotools_configure_options "--#{ARCH == 'x86_64' ? 'enable' : 'disable'}-64bit"

  autotools_install_extras do
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install-private-headers'
    FileUtils.ln_s "#{CREW_PREFIX}/bin/tclsh#{version.rpartition('.')[0]}", "#{CREW_DEST_PREFIX}/bin/tclsh"
  end
end
