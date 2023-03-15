require 'package'

class Maven < Package
  description 'Apache Maven is a software project management and comprehension tool.'
  homepage 'https://maven.apache.org/'
  version '3.9.0'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://dlcdn.apache.org/maven/maven-3/3.9.0/binaries/apache-maven-3.9.0-bin.tar.gz'
  source_sha256 'b118e624ec6f7abd8fc49e6cb23f134dbbab1119d88718fc09d798d33756dd72'

  depends_on 'openjdk8' unless File.exist? "#{CREW_PREFIX}/bin/java"

  no_compile_needed

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/apache-maven"
    FileUtils.cp_r Dir['.'], "#{CREW_DEST_PREFIX}/share/apache-maven"
    FileUtils.ln_s "#{CREW_PREFIX}/share/apache-maven/bin/mvn", "#{CREW_DEST_PREFIX}/bin"
  end
end
