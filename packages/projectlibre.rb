require 'package'

class Projectlibre < Package
  description 'ProjectLibre is project management software, the leading alternative to Microsoft Project.'
  homepage 'https://www.projectlibre.com/projectlibre-desktop/'
  version '1.9.8'
  license 'CPAL-1.0'
  compatibility 'x86_64'
  source_url "https://downloads.sourceforge.net/project/projectlibre/ProjectLibre/#{version}/projectlibre-#{version}.jar"
  source_sha256 'b8b6ed323fbe67f2d842f23914715b6c769c6bce92af38d3c90a3fa469fc4356'

  depends_on 'libx11'
  depends_on 'libxext'
  depends_on 'libxrender'
  depends_on 'libxtst'
  depends_on 'openjdk21'

  no_compile_needed

  def self.build
    File.write 'projectlibre.sh', <<~EOF
      #!/bin/bash
      java -jar #{CREW_PREFIX}/share/projectlibre/projectlibre.jar
    EOF
  end

  def self.install
    FileUtils.install "projectlibre-#{version}.jar", "#{CREW_DEST_PREFIX}/share/projectlibre/projectlibre.jar", mode: 0o644
    FileUtils.install 'projectlibre.sh', "#{CREW_DEST_PREFIX}/bin/projectlibre", mode: 0o755
  end

  def self.postinstall
    ExitMessage.add "\nType 'projectlibre' to get started.\n"
  end

  def self.postremove
    Package.agree_to_remove("#{HOME}/.java/.userPrefs/com/projectlibre1")
    Package.agree_to_remove("#{HOME}/.java/.userPrefs/org/projectlibre1")
  end
end
