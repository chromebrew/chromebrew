require 'package'

class Maven < Package
  description 'Apache Maven is a software project management and comprehension tool.'
  homepage 'https://maven.apache.org/'
  version '3.9.11'
  license 'Apache-2.0'
  compatibility 'all'
  source_url "https://dlcdn.apache.org/maven/maven-3/#{version}/binaries/apache-maven-#{version}-bin.tar.gz"
  source_sha256 '4b7195b6a4f5c81af4c0212677a32ee8143643401bc6e1e8412e6b06ea82beac'

  depends_on 'openjdk17' unless File.exist? "#{CREW_PREFIX}/bin/java"

  no_compile_needed

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/apache-maven"
    FileUtils.mv Dir['*'], "#{CREW_DEST_PREFIX}/share/apache-maven"
    FileUtils.ln_s "#{CREW_PREFIX}/share/apache-maven/bin/mvn", "#{CREW_DEST_PREFIX}/bin/mvn"
  end
end
