require 'package'

class Tcl < Package
  description 'Tcl (Tool Command Language) is a very powerful but easy to learn dynamic programming language, suitable for a very wide range of uses, including web and desktop applications, networking, administration, testing and many more.'
  homepage 'http://www.tcl.tk/'
  version '8.6.16'
  license 'tcltk'
  compatibility 'all'
  source_url "https://downloads.sourceforge.net/project/tcl/Tcl/#{version}/tcl#{version}-src.tar.gz"
  source_sha256 '91cb8fa61771c63c262efb553059b7c7ad6757afa5857af6265e4b0bdc2a14a5'
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

  def self.build
    FileUtils.chdir('unix') do
      @bit64 = ARCH == 'x86_64' ? 'enable' : 'disable'
      system "./configure #{CREW_CONFIGURE_OPTIONS} --#{@bit64}-64bit"
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
