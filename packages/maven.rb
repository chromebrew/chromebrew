require 'package'

class Maven < Package
  description 'Apache Maven is a software project management and comprehension tool.'
  homepage 'https://maven.apache.org/'
  version '3.9.16'
  license 'Apache-2.0'
  compatibility 'all'
  source_url "https://dlcdn.apache.org/maven/maven-3/#{version}/binaries/apache-maven-#{version}-bin.tar.gz"
  source_sha256 '80ffca22aed9e8b9713a232f3394fd81d7f20322df75efdb2b047dbd3e3a23bb'

  depends_on 'openjdk17' unless File.exist? "#{CREW_PREFIX}/bin/java"

  no_compile_needed

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/apache-maven"
    FileUtils.mv Dir['*'], "#{CREW_DEST_PREFIX}/share/apache-maven"
    FileUtils.ln_s "#{CREW_PREFIX}/share/apache-maven/bin/mvn", "#{CREW_DEST_PREFIX}/bin/mvn"
  end
end
