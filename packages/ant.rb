require 'package'

class Ant < Package
  description 'Apache Ant is a Java library and command-line tool whose mission is to drive processes described in build files as targets and extension points dependent upon each other.'
  homepage 'http://ant.apache.org/'
  version '1.10.7'
  source_url 'https://www.apache.org/dist/ant/source/apache-ant-1.10.7-src.tar.xz'
  source_sha256 'c8d68b396d9e44b49668bafe0c82f8c89497915254b5395d73d6f6e41d7a0e25'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'jdk8'

  def self.build
    system "JAVA_HOME=#{CREW_PREFIX}/share/jdk8 ./build.sh"
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/jdk8/"
    system "for dist in lib bin; do \
              cp -a dist/$dist/ #{CREW_DEST_PREFIX}/share/jdk8/; \
            done"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin/"
    system "for bin in ant antRun antRun.pl complete-ant-cmd.pl runant.pl runant.py; do \
              ln -s ../share/jdk8/bin/$bin #{CREW_DEST_PREFIX}/bin/; \
            done"
  end

  def self.postinstall
    puts
    puts "To complete the installation, execute the following:".lightblue
    puts "echo '# Apache Ant configuration' >> ~/.bashrc".lightblue
    puts "echo 'export JAVA_HOME=#{CREW_PREFIX}/share/jdk8' >> ~/.bashrc".lightblue
    puts "echo 'export ANT_HOME=$JAVA_HOME' >> ~/.bashrc".lightblue
    puts "source ~/.bashrc".lightblue
    puts
  end
end
