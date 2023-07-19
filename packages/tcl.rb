require 'package'

class Tcl < Package
  description 'Tcl (Tool Command Language) is a very powerful but easy to learn dynamic programming language, suitable for a very wide range of uses, including web and desktop applications, networking, administration, testing and many more.'
  homepage 'http://www.tcl.tk/'
  version '8.6.13'
  license 'tcltk'
  compatibility 'all'
  source_url "https://downloads.sourceforge.net/project/tcl/Tcl/#{version}/tcl#{version}-src.tar.gz"
  source_sha256 '43a1fae7412f61ff11de2cfd05d28cfc3a73762f354a417c62370a54e2caf066'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tcl/8.6.13_armv7l/tcl-8.6.13-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tcl/8.6.13_armv7l/tcl-8.6.13-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tcl/8.6.13_i686/tcl-8.6.13-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tcl/8.6.13_x86_64/tcl-8.6.13-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '2f64a7d1350b05414f52a3e12b5cf2d7d0396619c83810bea71eed443064b83a',
     armv7l: '2f64a7d1350b05414f52a3e12b5cf2d7d0396619c83810bea71eed443064b83a',
       i686: 'd36ca1f8dd507f12e5c2d43080bb8b5bd0e4b161efb1f3949fa4e46fd5bf6a46',
     x86_64: '02b7cc2f6a94226a4400348d62933eb4b297aa52380a4d5303ce865d34a8d639'
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
