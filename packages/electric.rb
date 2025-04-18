require 'package'

class Electric < Package
  description 'Electric is a computer-aided design system for electrical circuits.'
  homepage 'https://www.staticfreesoft.com/'
  version '9.08'
  license 'GPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://ftpmirror.gnu.org/electric/electricBinary-#{version}.jar"
  source_sha256 '7a8fbe5fac60989659a5197eabb4a1dac53a675adfa12c26c98a7d1089aeeb97'

  depends_on 'openjdk17'
  depends_on 'sommelier'

  no_compile_needed

  def self.build
    File.write 'electric.sh', <<~EOF
      #!/bin/bash
      java -jar #{CREW_PREFIX}/share/electric/electric.jar "$@"
    EOF
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/electric"
    FileUtils.mv "electricBinary-#{version}.jar", "#{CREW_DEST_PREFIX}/share/electric/electric.jar"
    FileUtils.install 'electric.sh', "#{CREW_DEST_PREFIX}/bin/electric", mode: 0o755
  end

  def self.postinstall
    ExitMessage.add "\nType 'electric' to get started.\n"
  end

  def self.postremove
    Package.agree_to_remove("#{HOME}/electric.log")
  end
end
