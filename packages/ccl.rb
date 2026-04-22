require 'package'

class Ccl < Package
  description 'Clozure CL is a fast, mature, open source Common Lisp implementation.'
  homepage 'https://ccl.clozure.com'
  version '1.13'
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
    aarch64: '8b250c4c3b876f27c40310008635c036387a1e1a4b9161b9f9d89723a6855147',
     armv7l: '8b250c4c3b876f27c40310008635c036387a1e1a4b9161b9f9d89723a6855147',
     x86_64: '70069ee74c6f0685df83eb6224ce22f3e7919e17b233476c784e440d60e26bf1'
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
