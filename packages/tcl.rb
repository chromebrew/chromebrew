require 'package'

class Tcl < Package
  description 'Tcl (Tool Command Language) is a very powerful but easy to learn dynamic programming language, suitable for a very wide range of uses, including web and desktop applications, networking, administration, testing and many more.'
  homepage 'http://www.tcl.tk/'
  @_ver = '8.6.11'
  @_ver_prelastdot = @_ver.rpartition('.')[0]
  version "#{@_ver}-1"
  license 'tcltk'
  compatibility 'all'
  source_url "https://downloads.sourceforge.net/project/tcl/Tcl/#{@_ver}/tcl#{@_ver}-src.tar.gz"
  source_sha256 '8c0486668586672c5693d7d95817cb05a18c5ecca2f40e2836b9578064088258'

  binary_url({
    aarch64: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/tcl-8.6.11-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/tcl-8.6.11-1-chromeos-armv7l.tar.xz',
       i686: 'https://downloads.sourceforge.net/project/chromebrew/i686/tcl-8.6.11-1-chromeos-i686.tar.xz',
     x86_64: 'https://downloads.sourceforge.net/project/chromebrew/x86_64/tcl-8.6.11-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '82ae2b101306c3a450a81a44e3b9d5e05b2a5f6bcfaba6bbe9907a26b04914aa',
     armv7l: '82ae2b101306c3a450a81a44e3b9d5e05b2a5f6bcfaba6bbe9907a26b04914aa',
       i686: '52dbbca5c17fc69ced4ae740c00f5c992dd0a7495753c9c32c2ffe6a0ce3f052',
     x86_64: '2a7b7348a8b4c83b3bd5b6e6d584911ebba10db0b1485f974888ec4f5734f27f'
  })

  # tk breaks if tcl is built with lto
  def self.build
    FileUtils.chdir('unix') do
      if ARCH == 'x86_64'
        system "env CFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE' \
      CXXFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE' \
      LDFLAGS='-fno-stack-protector -U_FORTIFY_SOURCE' \
      ./configure #{CREW_OPTIONS} --enable-64bit"
      else
        system "env CFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE' \
      CXXFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE' \
      LDFLAGS='-fno-stack-protector -U_FORTIFY_SOURCE' \
      ./configure #{CREW_OPTIONS} --disable-64bit"
      end
      system 'make'
    end
  end

  def self.install
    FileUtils.chdir('unix') do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install-private-headers'
      FileUtils.ln_s "#{CREW_PREFIX}/bin/tclsh#{@_ver_prelastdot}", "#{CREW_DEST_PREFIX}/bin/tclsh"
    end
  end
end
