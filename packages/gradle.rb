require 'package'

class Gradle < Package
  description 'From mobile apps to microservices, from small startups to big enterprises, Gradle helps teams build, automate and deliver better software, faster.'
  homepage 'https://gradle.org/'
  version '8.13'
  license 'Apache-2.0'
  compatibility 'all'
  source_url "https://services.gradle.org/distributions/gradle-#{version}-bin.zip"
  source_sha256 '20f1b1176237254a6fc204d8434196fa11a4cfb387567519c61556e8710aed78'

  depends_on 'openjdk8' unless File.exist? "#{CREW_PREFIX}/bin/java"

  no_compile_needed

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/gradle"
    FileUtils.cp_r '.', "#{CREW_DEST_PREFIX}/share/gradle"
    FileUtils.ln_s "#{CREW_PREFIX}/share/gradle/bin/gradle", "#{CREW_DEST_PREFIX}/bin"
  end
end
