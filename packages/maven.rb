require 'package'

class Maven < Package
  description 'Apache Maven is a software project management and comprehension tool.'
  homepage 'https://maven.apache.org/'
  version '3.5.2'
  source_url 'http://mirror.csclub.uwaterloo.ca/apache/maven/maven-3/3.5.2/binaries/apache-maven-3.5.2-bin.tar.gz'
  source_sha256 '707b1f6e390a65bde4af4cdaf2a24d45fc19a6ded00fff02e91626e3e42ceaff'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'jdk8'

  def self.install
    system "mkdir -p #{CREW_DEST_PREFIX}/bin"
    system "mkdir -p #{CREW_DEST_PREFIX}/share/apache-maven"
    system "cp -r . #{CREW_DEST_PREFIX}/share/apache-maven"
    system "ln -s #{CREW_PREFIX}/share/apache-maven/bin/mvn #{CREW_DEST_PREFIX}/bin"
  end
end
