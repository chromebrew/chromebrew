require 'package'

class Gradle < Package
  description 'From mobile apps to microservices, from small startups to big enterprises, Gradle helps teams build, automate and deliver better software, faster.'
  homepage 'https://gradle.org/'
  version '4.10'
  compatibility 'all'
  source_url 'https://services.gradle.org/distributions/gradle-4.10-bin.zip'
  source_sha256 '248cfd92104ce12c5431ddb8309cf713fe58de8e330c63176543320022f59f18'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'jdk8'

  def self.install
    system "mkdir -p #{CREW_DEST_PREFIX}/bin"
    system "mkdir -p #{CREW_DEST_PREFIX}/share/gradle"
    system "cp -r . #{CREW_DEST_PREFIX}/share/gradle"
    system "ln -s #{CREW_PREFIX}/share/gradle/bin/gradle #{CREW_DEST_PREFIX}/bin"
  end
end
