require 'package'

class Logisim < Package
  description 'An educational tool for designing and simulating digital logic circuits'
  homepage 'https://sourceforge.net/projects/circuit/'
  version '2.7.1'
  license 'GPLv2'
  compatibility 'x86_64 aarch64 armv7l'
  source_url "https://downloads.sourceforge.net/project/circuit/2.7.x/#{version}/logisim-generic-#{version}.jar"
  source_sha256 '362a78c12ad18c203fed868872c4a01cd9c12141379d92e892bbe2c37e627bc2'

  depends_on 'openjdk8'
  depends_on 'sommelier'

  no_compile_needed

  def self.build
    logisim = <<~EOF
      #!/bin/bash
      cd #{CREW_PREFIX}/share/logisim
      java -jar logisim-generic-#{version}.jar "$@"
    EOF
    File.write('logisim', logisim)
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/logisim"
    FileUtils.install "logisim-generic-#{version}.jar", "#{CREW_DEST_PREFIX}/share/logisim", mode: 0o644
    FileUtils.install 'logisim', "#{CREW_DEST_PREFIX}/bin/logisim", mode: 0o755
  end

  def self.postinstall
    puts "\nType 'logisim' to get started.\n".lightblue
  end
end
