require 'package'

class Ccl < Package
  description 'Clozure CL is a fast, mature, open source Common Lisp implementation.'
  homepage 'https://ccl.clozure.com'
  version '1.11.5'
  compatibility 'all'

  # arm only has a 32-bit build in the archive
  # intel has both 32-bit and 64-bit in the archive
  case ARCH
  when 'aarch64', 'armv7l'
    source_url 'https://github.com/Clozure/ccl/releases/download/v1.11.5/ccl-1.11.5-linuxarm.tar.gz'
    source_sha256 'c2e449512717e3a01e192a902a0786dd103bfb9537aed77b88663daf7f0b145c'
  when 'i686', 'x86_64'
    source_url 'https://github.com/Clozure/ccl/releases/download/v1.11.5/ccl-1.11.5-linuxx86.tar.gz'
    source_sha256 'b80850d8d6ca8662499975f1cd76bf51affdd29e2025796ddcff6576fe704143'
  end

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/ccl-1.11.5-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/ccl-1.11.5-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/ccl-1.11.5-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/ccl-1.11.5-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'c76d7ef3a190d6f5df52b00de5b520e96c63e07d1703bc5325a8f692dc85342c',
     armv7l: 'c76d7ef3a190d6f5df52b00de5b520e96c63e07d1703bc5325a8f692dc85342c',
       i686: '57617fc472305b926781c61248fb10e6732454eaf89022e0583d7f1cea42a87f',
     x86_64: '3d2632f8390c449f3ecee54d9101e4779590b676533d2b17b759e37db815a275',
  })

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/ccl"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
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
