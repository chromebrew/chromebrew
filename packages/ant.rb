require 'package'

class Ant < Package
  description 'Apache Ant is a Java library and command-line tool whose mission is to drive processes described in build files as targets and extension points dependent upon each other.'
  homepage 'http://ant.apache.org/'
  version '1.10.7'
  compatibility 'all'
  source_url 'https://www.apache.org/dist/ant/source/apache-ant-1.10.7-src.tar.xz'
  source_sha256 'c8d68b396d9e44b49668bafe0c82f8c89497915254b5395d73d6f6e41d7a0e25'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/ant-1.10.7-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/ant-1.10.7-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/ant-1.10.7-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/ant-1.10.7-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '8c8f4cf7c36b17cee645c7e7b97ba96d56a61f423471ec90bfe5538c635d7c06',
     armv7l: '8c8f4cf7c36b17cee645c7e7b97ba96d56a61f423471ec90bfe5538c635d7c06',
       i686: '6cd682307210e3164e22a59cda0719d68476e8c3303e5fa1d262ca5a83753720',
     x86_64: '4d135fc9b5b3e76f9fc614dfd93a781451d9b0901281a2b8dd6a20a28d76bc62',
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
