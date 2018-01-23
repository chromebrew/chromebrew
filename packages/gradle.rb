require 'package'

class Gradle < Package
  description 'From mobile apps to microservices, from small startups to big enterprises, Gradle helps teams build, automate and deliver better software, faster.'
  homepage 'https://gradle.org/'
  version '4.4.1'
  source_url 'https://services.gradle.org/distributions/gradle-4.4.1-bin.zip'
  source_sha256 'e7cf7d1853dfc30c1c44f571d3919eeeedef002823b66b6a988d27e919686389'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'unzip' => :build
  depends_on 'jdk8'

  def self.install
    system "mkdir -p #{CREW_DEST_PREFIX}/bin"
    system "mkdir -p #{CREW_DEST_PREFIX}/share/gradle"
    system "cp -r . #{CREW_DEST_PREFIX}/share/gradle"
    system "ln -s #{CREW_PREFIX}/share/gradle/bin/gradle #{CREW_DEST_PREFIX}/bin"
  end
end
