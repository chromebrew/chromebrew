require 'package'

class Tika < Package
  description 'The Apache Tika™ toolkit detects and extracts metadata and text from over a thousand different file types (such as PPT, XLS, and PDF).'
  homepage 'https://tika.apache.org/'
  version '9675474'
  license 'Apache-2.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://dlcdn.apache.org/tika/#{version}/tika-app-#{version}.jar"
  source_sha256 '73d6fec4f16d056a45dbd14c7748ee7c5946fc8826ea9ae517911e501e094855'

  depends_on 'openjdk17'
  depends_on 'libx11'
  depends_on 'libxext'
  depends_on 'libxrender'
  depends_on 'libxtst'

  no_compile_needed

  def self.build
    File.write 'tika.sh', <<~EOF
      #!/bin/bash
      java -jar #{CREW_PREFIX}/share/tika/tika-app-#{version}.jar
    EOF
  end

  def self.install
    FileUtils.install "tika-app-#{version}.jar", "#{CREW_DEST_PREFIX}/share/tika/tika-app-#{version}.jar", mode: 0o644
    FileUtils.install 'tika.sh', "#{CREW_DEST_PREFIX}/bin/tika", mode: 0o755
  end

  def self.postinstall
    ExitMessage.add "\nType 'tika' to get started.\n"
  end
end
