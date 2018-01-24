require 'package'

class Gradle < Package
  description 'From mobile apps to microservices, from small startups to big enterprises, Gradle helps teams build, automate and deliver better software, faster.'
  homepage 'https://gradle.org/'
  version '4.4.1'
  source_url 'https://services.gradle.org/distributions/gradle-4.4.1-bin.zip'
  source_sha256 'e7cf7d1853dfc30c1c44f571d3919eeeedef002823b66b6a988d27e919686389'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gradle-4.4.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gradle-4.4.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gradle-4.4.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gradle-4.4.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '4ec7547d20b525ba602d9f83278d8225ae58fd44fd205b62b7f44c90a0175cf2',
     armv7l: '4ec7547d20b525ba602d9f83278d8225ae58fd44fd205b62b7f44c90a0175cf2',
       i686: '8e42654ef1f4b6382f755434ad4f9392fe4298e867699991921fddebcc6c3983',
     x86_64: '91e2e68a9920e25d4064548af81a6159eb5c656a8ad38452aac5bf173761502f',
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
