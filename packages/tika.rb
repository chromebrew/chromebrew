require 'package'

class Tika < Package
  description 'The Apache Tika™ toolkit detects and extracts metadata and text from over a thousand different file types (such as PPT, XLS, and PDF).'
  homepage 'https://tika.apache.org/'
  version '2.9.2'
  license 'Apache-2.0'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://dlcdn.apache.org/tika/2.9.2/tika-app-2.9.2.jar'
  source_sha256 '87e06f88c801fcb2beae5f15e707241edb14da468a154ad78be4e31ff982c3da'

  depends_on 'openjdk8'
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
    ExitMessage.add "\nType 'tika' to get started.\n".lightblue
  end
end
