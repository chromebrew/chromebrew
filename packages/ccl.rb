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
