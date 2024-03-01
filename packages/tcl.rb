require 'package'

class Tcl < Package
  description 'Tcl (Tool Command Language) is a very powerful but easy to learn dynamic programming language, suitable for a very wide range of uses, including web and desktop applications, networking, administration, testing and many more.'
  homepage 'http://www.tcl.tk/'
  version '8.6.14'
  license 'tcltk'
  compatibility 'all'
  source_url "https://downloads.sourceforge.net/project/tcl/Tcl/#{version}/tcl#{version}-src.tar.gz"
  source_sha256 '5880225babf7954c58d4fb0f5cf6279104ce1cd6aa9b71e9a6322540e1c4de66'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a2f6571a792ae2827c9991d3dac762036659b61b03179deeb02cffa01788d0f2',
     armv7l: 'a2f6571a792ae2827c9991d3dac762036659b61b03179deeb02cffa01788d0f2',
       i686: 'd36ca1f8dd507f12e5c2d43080bb8b5bd0e4b161efb1f3949fa4e46fd5bf6a46',
     x86_64: '7c381e1f0fb53435c0d7ffe504e1c217ffc40e702f28779c1ec668f7548e2225'
  })

  depends_on 'glibc' # R
  depends_on 'zlibpkg' # R

  no_lto

  def self.build
    FileUtils.chdir('unix') do
      @bit64 = ARCH == 'x86_64' ? 'enable' : 'disable'
      system "./configure #{CREW_OPTIONS} --#{@bit64}-64bit"
      system 'make'
    end
  end

  def self.install
    FileUtils.chdir('unix') do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install-private-headers'
      FileUtils.ln_s "#{CREW_PREFIX}/bin/tclsh#{version.rpartition('.')[0]}", "#{CREW_DEST_PREFIX}/bin/tclsh"
    end
  end
end
