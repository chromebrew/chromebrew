require 'package'

class Ccl < Package
  description 'Clozure CL is a fast, mature, open source Common Lisp implementation.'
  homepage 'https://ccl.clozure.com'
  version '1.11.5'

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
  })
  binary_sha256 ({
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
