require 'package'

class Maven < Package
  description 'Apache Maven is a software project management and comprehension tool.'
  homepage 'https://maven.apache.org/'
  version '3.5.2'
  compatibility 'all'
  source_url 'http://mirror.csclub.uwaterloo.ca/apache/maven/maven-3/3.5.2/binaries/apache-maven-3.5.2-bin.tar.gz'
  source_sha256 '707b1f6e390a65bde4af4cdaf2a24d45fc19a6ded00fff02e91626e3e42ceaff'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/maven-3.5.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/maven-3.5.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/maven-3.5.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/maven-3.5.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'ab7d4fa404f53d5876e0a977a4eeaf1d38f3d9738ece113c9507c968ed2eac91',
     armv7l: 'ab7d4fa404f53d5876e0a977a4eeaf1d38f3d9738ece113c9507c968ed2eac91',
       i686: '8dcd4e8924457622ccd8770258274f16a63156a6fdb05b3a55320dabaa9733d0',
     x86_64: '62475788ab2144a67de31b08a946d613c277f9557f2122aff8cc996bd87bde2f',
  })

  depends_on 'jdk8'

  def self.install
    system "mkdir -p #{CREW_DEST_PREFIX}/bin"
    system "mkdir -p #{CREW_DEST_PREFIX}/share/apache-maven"
    system "cp -r . #{CREW_DEST_PREFIX}/share/apache-maven"
    system "ln -s #{CREW_PREFIX}/share/apache-maven/bin/mvn #{CREW_DEST_PREFIX}/bin"
  end
end
