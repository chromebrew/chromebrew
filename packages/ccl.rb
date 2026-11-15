require 'package'

class Ccl < Package
  description 'Clozure CL is a fast, mature, open source Common Lisp implementation.'
  homepage 'https://ccl.clozure.com'
  version '1.14'
  license 'Apache-2.0'
  compatibility 'aarch64 armv7l x86_64'
  min_glibc '2.32'
  # arm only has a 32-bit build in the archive
  # intel has both 32-bit and 64-bit in the archive
  source_url({
    aarch64: "https://github.com/Clozure/ccl/releases/download/v#{version}/ccl-#{version}-linuxarm.tar.gz",
     armv7l: "https://github.com/Clozure/ccl/releases/download/v#{version}/ccl-#{version}-linuxarm.tar.gz",
     x86_64: "https://github.com/Clozure/ccl/releases/download/v#{version}/ccl-#{version}-linuxx86.tar.gz"
  })
  source_sha256({
    aarch64: '5bdbdb53014799c0e61592d4f3f76224f7044aabcf814de294d5be4ab611a4dd',
     armv7l: '5bdbdb53014799c0e61592d4f3f76224f7044aabcf814de294d5be4ab611a4dd',
     x86_64: '96fff67c53b56dc67acc06e92ff1774b73401564650669c95e7c63f1200a4f5d'
  })

  no_compile_needed

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/ccl"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.cp_r Dir.pwd, "#{CREW_DEST_PREFIX}/share"
    FileUtils.rm_rf "#{CREW_DEST_PREFIX}/share/ccl/.git"
    # the name of the repl binary and kernel image are different for each arch
    case ARCH
    when 'aarch64', 'armv7l'
      FileUtils.ln_s "#{CREW_PREFIX}/share/ccl/armcl", "#{CREW_DEST_PREFIX}/bin/ccl"
    when 'i686'
      FileUtils.ln_s "#{CREW_PREFIX}/share/ccl/lx86cl", "#{CREW_DEST_PREFIX}/bin/ccl"
    when 'x86_64'
      FileUtils.ln_s "#{CREW_PREFIX}/share/ccl/lx86cl64", "#{CREW_DEST_PREFIX}/bin/ccl"
    end
  end
end
