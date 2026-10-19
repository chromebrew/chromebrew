require 'package'

class Tika < Package
  description 'The Apache Tika™ toolkit detects and extracts metadata and text from over a thousand different file types (such as PPT, XLS, and PDF).'
  homepage 'https://tika.apache.org/'
  version '4.1.0'
  license 'Apache-2.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://downloads.apache.org/tika/#{version}/tika-app-#{version}.zip"
  source_sha256 '7b570f0a762ee5a94166c9caa1127b00278eaa83a0d5a38633f14c3132734087'

  depends_on 'openjdk17' => :logical
  depends_on 'libx11' => :library
  depends_on 'libxext' => :library
  depends_on 'libxrender' => :library
  depends_on 'libxtst' => :library

  no_compile_needed

  def self.build
    File.write 'tika.sh', <<~EOF
      #!/bin/bash
      cd #{CREW_PREFIX}/share/tika
      java -jar tika-app-#{version}.jar "$@"
    EOF
  end

  def self.install
    FileUtils.install 'tika.sh', "#{CREW_DEST_PREFIX}/bin/tika", mode: 0o755
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/tika"
    FileUtils.mv Dir['*'], "#{CREW_DEST_PREFIX}/share/tika"
  end

  def self.postinstall
    ExitMessage.add "\nType 'tika' to get started.\n"
  end
end
