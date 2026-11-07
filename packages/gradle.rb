require 'package'

class Gradle < Package
  description 'From mobile apps to microservices, from small startups to big enterprises, Gradle helps teams build, automate and deliver better software, faster.'
  homepage 'https://gradle.org/'
  version '9.9.0'
  license 'Apache-2.0'
  compatibility 'all'
  source_url "https://github.com/gradle/gradle-distributions/releases/download/v#{version}/gradle-#{version}-bin.zip"
  source_sha256 '0b00b0ffe07c4d4789c12d4935a44a7057d55774b7540bd4a3f76f336deb177a'

  depends_on 'openjdk8' unless File.exist? "#{CREW_PREFIX}/bin/java"

  no_compile_needed

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/gradle"
    FileUtils.cp_r '.', "#{CREW_DEST_PREFIX}/share/gradle"
    FileUtils.ln_s "#{CREW_PREFIX}/share/gradle/bin/gradle", "#{CREW_DEST_PREFIX}/bin"
  end
end
