require 'package'

class Ant < Package
  description 'Apache Ant is a Java library and command-line tool whose mission is to drive processes described in build files as targets and extension points dependent upon each other.'
  homepage 'http://ant.apache.org/'
  version '1.10.2'
  source_url 'https://www.apache.org/dist/ant/binaries/apache-ant-1.10.2-bin.tar.xz'
  source_sha256 '361c8ad2ed8341416e323e7c28af10a8297170a80fdffba294a5c2031527bb6c'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/ant-1.10.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/ant-1.10.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/ant-1.10.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/ant-1.10.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '8a90bd6448e3937ff4d5c98e83ade7e3eb3af7b9e48ef541d16796bf17165305',
     armv7l: '8a90bd6448e3937ff4d5c98e83ade7e3eb3af7b9e48ef541d16796bf17165305',
       i686: 'db844b8b98315d929a9a1fec83280544cee3c003930ad901a0cfa079c534ece5',
     x86_64: '0b0ba2ea0120b892b8ecba242fbad5897cdc7f695ff433d8ef632145426e90b6',
  })

  depends_on 'jdk8'
  depends_on 'unzip' => :build

  def self.install
    system "rm -f bin/*.bat"
    system "rm -f bin/*.cmd"
    system "rm -f lib/README"
    system "mkdir -p #{CREW_DEST_PREFIX}"
    system "mkdir -p #{CREW_DEST_LIB_PREFIX}"
    system "cp -r bin/ #{CREW_DEST_PREFIX}"
    system "cp -r lib/* #{CREW_DEST_LIB_PREFIX}"
  end

  def self.postinstall
    puts
    puts "To complete the installation, execute the following:".lightblue
    puts "echo '# Apache Ant configuration' >> ~/.bashrc".lightblue
    puts "echo 'export ANT_HOME=#{CREW_PREFIX}' >> ~/.bashrc".lightblue
    puts "echo 'export JAVA_HOME=#{CREW_PREFIX}/share/jdk8' >> ~/.bashrc".lightblue
    puts "source ~/.bashrc".lightblue
    puts
  end
end
