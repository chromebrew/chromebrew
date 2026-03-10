require 'package'

class Gradle < Package
  description 'From mobile apps to microservices, from small startups to big enterprises, Gradle helps teams build, automate and deliver better software, faster.'
  homepage 'https://gradle.org/'
  version '9.4.0'
  license 'Apache-2.0'
  compatibility 'all'
  source_url "https://github.com/gradle/gradle-distributions/releases/download/v#{version}/gradle-#{version}-bin.zip"
  source_sha256 '60ea723356d81263e8002fec0fcf9e2b0eee0c0850c7a3d7ab0a63f2ccc601f3'

  depends_on 'openjdk8' unless File.exist? "#{CREW_PREFIX}/bin/java"

  no_compile_needed

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/gradle"
    FileUtils.cp_r '.', "#{CREW_DEST_PREFIX}/share/gradle"
    FileUtils.ln_s "#{CREW_PREFIX}/share/gradle/bin/gradle", "#{CREW_DEST_PREFIX}/bin"
  end
end
