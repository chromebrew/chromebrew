require 'package'

class Pdfbox < Package
  description 'The Apache PDFBox® library is an open source Java tool for working with PDF documents.'
  homepage 'https://pdfbox.apache.org/'
  version '3.0.6'
  license 'Apache-2.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://dlcdn.apache.org/pdfbox/#{version}/pdfbox-app-#{version}.jar"
  source_sha256 '28948291a7d6addb91a158292f2e9348d2143720e25a9c87c91bbdd4b088475f'

  depends_on 'openjdk17' unless File.exist?("#{CREW_PREFIX}/bin/java") # R
  depends_on 'libx11' # R
  depends_on 'libxext' # R
  depends_on 'libxrender' # R
  depends_on 'libxtst' # R

  no_compile_needed

  def self.build
    File.write 'pdfbox.sh', <<~EOF
      #!/bin/bash
      java -jar #{CREW_PREFIX}/share/pdfbox/pdfbox-app.jar "$@"
    EOF
  end

  def self.install
    FileUtils.install "pdfbox-app-#{version}.jar", "#{CREW_DEST_PREFIX}/share/pdfbox/pdfbox-app.jar"
    FileUtils.install 'pdfbox.sh', "#{CREW_DEST_PREFIX}/bin/pdfbox", mode: 0o755
  end

  def self.postinstall
    ExitMessage.add "\nType 'pdfbox help' to get started.\n"
  end
end
