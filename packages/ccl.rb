require 'package'

class Ccl < Package
  description 'Clozure CL is a fast, mature, open source Common Lisp implementation.'
  homepage 'https://ccl.clozure.com'
  version '1.11'

  # arm only has a 32-bit build in the archive
  # intel has both 32-bit and 64-bit in the archive
  case ARCH
  when 'aarch64', 'armv7l'
    source_url 'ftp://ftp.clozure.com/pub/release/1.11/ccl-1.11-linuxarm.tar.gz'
    source_sha256 '64a1911fbe516b73964b377df360c3a40695c6155e0730a6590c67f1953a88f4'
  when 'i686', 'x86_64'
    source_url 'ftp://ftp.clozure.com/pub/release/1.11/ccl-1.11-linuxx86.tar.gz'
    source_sha256 '08e885e8c2bb6e4abd42b8e8e2b60f257c6929eb34b8ec87ca1ecf848fac6d70'
  end

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/ccl-1.11-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/ccl-1.11-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/ccl-1.11-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/ccl-1.11-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'cfb1be8fc272f1c2bdaaacecfc78fd5586d066f15a14343f30a4e8266b9762e8',
     armv7l: 'cfb1be8fc272f1c2bdaaacecfc78fd5586d066f15a14343f30a4e8266b9762e8',
       i686: 'bde1a888168ba4a8489186e2a365d0ce4400cec13f862e6761e0478a95ee0381',
     x86_64: '526d1b580cd4e0295368dae45a165d082f8e717db7a4b4168be3fc4e3195c892',
  })

  def self.install
    system "mkdir -p #{CREW_DEST_PREFIX}/share/ccl"
    system "mkdir -p #{CREW_DEST_PREFIX}/bin"
    FileUtils.cp_r Dir.pwd, "#{CREW_DEST_PREFIX}/share"
    # the name of the repl binary and kernel image are different for each arch
    case ARCH
    when 'aarch64', 'armv7l'
      system "ln -s #{CREW_PREFIX}/share/ccl/armcl #{CREW_DEST_PREFIX}/bin/ccl"
    when 'i686'
      system "ln -s #{CREW_PREFIX}/share/ccl/lx86cl #{CREW_DEST_PREFIX}/bin/ccl"
    when 'x86_64'
      system "ln -s #{CREW_PREFIX}/share/ccl/lx86cl64 #{CREW_DEST_PREFIX}/bin/ccl"
    end
  end
end
