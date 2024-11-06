require 'package'

class Maven < Package
  description 'Apache Maven is a software project management and comprehension tool.'
  homepage 'https://maven.apache.org/'
  version '3.9.8'
  license 'Apache-2.0'
  compatibility 'all'
  source_url "https://dlcdn.apache.org/maven/maven-3/#{version}/binaries/apache-maven-#{version}-bin.tar.gz"
  source_sha256 '067672629075b740e3d0a928e21021dd615a53287af36d4ccca44e87e081d102'

  depends_on 'openjdk8' unless File.exist? "#{CREW_PREFIX}/bin/java"

  no_compile_needed

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/apache-maven"
    FileUtils.mv Dir['*'], "#{CREW_DEST_PREFIX}/share/apache-maven"
    FileUtils.ln_s "#{CREW_PREFIX}/share/apache-maven/bin/mvn", "#{CREW_DEST_PREFIX}/bin/mvn"
  end
end
