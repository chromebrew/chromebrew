require 'package'

class Gradle < Package
  description 'From mobile apps to microservices, from small startups to big enterprises, Gradle helps teams build, automate and deliver better software, faster.'
  homepage 'https://gradle.org/'
  version '8.8'
  license 'Apache-2.0'
  compatibility 'all'
  source_url "https://services.gradle.org/distributions/gradle-#{version}-bin.zip"
  source_sha256 'a4b4158601f8636cdeeab09bd76afb640030bb5b144aafe261a5e8af027dc612'

  depends_on 'openjdk8' unless File.exist? "#{CREW_PREFIX}/bin/java"

  no_compile_needed

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/gradle"
    FileUtils.cp_r '.', "#{CREW_DEST_PREFIX}/share/gradle"
    FileUtils.ln_s "#{CREW_PREFIX}/share/gradle/bin/gradle", "#{CREW_DEST_PREFIX}/bin"
  end
end
