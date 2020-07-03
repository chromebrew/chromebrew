require 'package'

class Gradle < Package
  description 'From mobile apps to microservices, from small startups to big enterprises, Gradle helps teams build, automate and deliver better software, faster.'
  homepage 'https://gradle.org/'
  version '6.5'
  compatibility 'all'
  source_url 'https://services.gradle.org/distributions/gradle-6.5-bin.zip'
  source_sha256 '23e7d37e9bb4f8dabb8a3ea7fdee9dd0428b9b1a71d298aefd65b11dccea220f'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gradle-6.5-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gradle-6.5-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gradle-6.5-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gradle-6.5-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'b490a6fb163a63945fc2a883ae0a3d05e9a11165ea454e01be578367e505ba30',
     armv7l: 'b490a6fb163a63945fc2a883ae0a3d05e9a11165ea454e01be578367e505ba30',
       i686: '42a931993440cd3d0f94611fec4260e050214751c50274448a4ca2c8d922f322',
     x86_64: '597496258ce7516703f2879740b7b491a2f2329876d589c5d4fdd44a823d619d',
  })

  depends_on 'jdk8'

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/gradle"
    FileUtils.cp_r '.', "#{CREW_DEST_PREFIX}/share/gradle"
    FileUtils.ln_s "#{CREW_PREFIX}/share/gradle/bin/gradle", "#{CREW_DEST_PREFIX}/bin"
  end
end
