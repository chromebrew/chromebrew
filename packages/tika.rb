require 'package'

class Tika < Package
  description 'The Apache Tika™ toolkit detects and extracts metadata and text from over a thousand different file types (such as PPT, XLS, and PDF).'
  homepage 'https://tika.apache.org/'
  version '2.9.0'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://dlcdn.apache.org/tika/2.9.0/tika-app-2.9.0.jar'
  source_sha256 '390382b0ad31a7da55d83cce58538f4b59988eda6ebdf259459d4ef109df1b06'

  depends_on 'openjdk8'
  depends_on 'libx11'
  depends_on 'libxext'
  depends_on 'libxrender'
  depends_on 'libxtst'

  no_compile_needed

  def self.build
    tika = <<~EOF
      #!/bin/bash
      java -jar #{CREW_PREFIX}/share/tika/tika-app-#{version}.jar
    EOF
    File.write('tika.sh', tika)
  end

  def self.install
    FileUtils.install "tika-app-#{version}.jar", "#{CREW_DEST_PREFIX}/share/tika/tika-app-#{version}.jar", mode: 0o644
    FileUtils.install 'tika.sh', "#{CREW_DEST_PREFIX}/bin/tika", mode: 0o755
  end

  def self.postinstall
    puts "\nType 'tika' to get started.\n".lightblue
  end
end
