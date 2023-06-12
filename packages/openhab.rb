require 'package'

class Openhab < Package
  description 'A vendor and technology agnostic open source automation software for your home'
  homepage 'https://www.openhab.org/'
  version '3.2.0'
  license 'Eclipse Public License 2.0'
  compatibility 'x86_64'
  source_url 'https://openhab.jfrog.io/artifactory/libs-release-local/org/openhab/distro/openhab/3.2.0/openhab-3.2.0.tar.gz'
  source_sha256 'e8185adcaabdec4b860c22ec854f37db0aa490d47e3f8654cef0f1dd7346d476'

  binary_url({})
  binary_sha256({})

  depends_on 'jdk11'

  def self.build
    openhab = <<~EOF
      #!/bin/bash
      cd #{CREW_PREFIX}/share/openhab
      ./start.sh
    EOF
    File.write('openhab.sh', openhab)
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/openhab"
    FileUtils.install 'openhab.sh', "#{CREW_DEST_PREFIX}/bin/openhab", mode: 0o755
    FileUtils.mv Dir['*'], "#{CREW_DEST_PREFIX}/share/openhab"
  end

  def self.postinstall
    puts "\nTo get started, execute 'openhab'.\n".lightblue
  end
end
