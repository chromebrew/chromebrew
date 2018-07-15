require 'package'

class Autosetup < Package
  description 'autosetup is a tool, similar to autoconf, to configure a build system'
  homepage 'http://msteveb.github.io/autosetup/'
  version '0.6.7'
  source_url 'https://github.com/msteveb/autosetup/archive/v0.6.7.tar.gz'
  source_sha256 'a8f852e10374261bf96bd19f03fac667b7332ff6ceef858e5199112d1f2782ce'

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
