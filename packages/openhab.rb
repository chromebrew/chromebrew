require 'package'

class Openhab < Package
  description 'A vendor and technology agnostic open source automation software for your home'
  homepage 'https://www.openhab.org/'
  @_ver = '3.1.0'
  version @_ver
  license 'Eclipse Public License 2.0'
  compatibility 'x86_64'
  source_url 'https://ci.openhab.org/job/openHAB3-Distribution/lastSuccessfulBuild/artifact/distributions/openhab/target/openhab-3.1.0-SNAPSHOT.tar.gz'
  source_sha256 'cecf5a13ba0d1003da5366eaa5d23c3adb93f574c4d471ecbca38763c36554f7'

  binary_url({
  })
  binary_sha256({
  })

  depends_on 'jdk11'

  def self.build
    openhab = <<~EOF
    #!/bin/bash
    cd #{CREW_PREFIX}/share/openhab
    ./start.sh
    EOF
    IO.write('openhab.sh', openhab)
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
