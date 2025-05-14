require 'package'

class Gradle < Package
  description 'From mobile apps to microservices, from small startups to big enterprises, Gradle helps teams build, automate and deliver better software, faster.'
  homepage 'https://gradle.org/'
  version '8.14.0'
  license 'Apache-2.0'
  compatibility 'all'
  source_url "https://github.com/gradle/gradle-distributions/releases/download/v#{version}/gradle-8.14-bin.zip"
  source_sha256 '61ad310d3c7d3e5da131b76bbf22b5a4c0786e9d892dae8c1658d4b484de3caa'

  depends_on 'openjdk8' unless File.exist? "#{CREW_PREFIX}/bin/java"

  no_compile_needed

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/gradle"
    FileUtils.cp_r '.', "#{CREW_DEST_PREFIX}/share/gradle"
    FileUtils.ln_s "#{CREW_PREFIX}/share/gradle/bin/gradle", "#{CREW_DEST_PREFIX}/bin"
  end
end
