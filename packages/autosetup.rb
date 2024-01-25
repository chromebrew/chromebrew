require 'package'

class Autosetup < Package
  description 'autosetup is a tool, similar to autoconf, to configure a build system'
  homepage 'https://msteveb.github.io/autosetup/'
  version '0.7.0'
  license 'BSD-2'
  compatibility 'all'
  source_url 'https://github.com/msteveb/autosetup/archive/v0.7.0.tar.gz'
  source_sha256 '473123b3921acc7b623d2d4a6175a058bf685c0ae3676850fb867026d67244cb'

  binary_sha256({})

  depends_on 'tcl'

  def self.build
    system 'make'
  end

  def self.install
    system "./autosetup --sysinstall=#{CREW_DEST_PREFIX}"
  end
end
