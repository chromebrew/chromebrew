require 'package'

class Autosetup < Package
  description 'autosetup is a tool, similar to autoconf, to configure a build system'
  homepage 'http://msteveb.github.io/autosetup/'
  version '0.6.9'
  compatibility 'all'
  source_url 'https://github.com/msteveb/autosetup/archive/v0.6.9.tar.gz'
  source_sha256 '4620bf17508e3c00e028d3376350e48372c6945b8ac29e0528c0ece0ac978bce'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'tcl'

  def self.build
    system 'make'
  end

  def self.install
    system "./autosetup --sysinstall=#{CREW_DEST_PREFIX}"
  end
end
