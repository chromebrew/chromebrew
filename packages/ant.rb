require 'package'

class Ant < Package
  description 'Apache Ant is a Java library and command-line tool whose mission is to drive processes described in build files as targets and extension points dependent upon each other.'
  homepage 'http://ant.apache.org/'
  version '1.10.1'
  source_url 'http://apache.mirror.vexxhost.com/ant/binaries/apache-ant-1.10.1-bin.zip'
  source_sha256 '0acf6f46a71985912f9c2c768795b97e5c26bc9a7a0b61d27af8287f8b96cd8e'

  binary_url ({
  })
  binary_sha256 ({
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
