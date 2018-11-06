require 'package'

class Ant < Package
  description 'Apache Ant is a Java library and command-line tool whose mission is to drive processes described in build files as targets and extension points dependent upon each other.'
  homepage 'http://ant.apache.org/'
  version '1.10.5'
  source_url 'https://www.apache.org/dist/ant/source/apache-ant-1.10.5-src.tar.xz'
  source_sha256 'ec7c704e22a2b0167e1ff35cc3d4198267e6489f142aa3e9da1b7fe6e39ff53d'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/ant-1.10.5-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/ant-1.10.5-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/ant-1.10.5-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/ant-1.10.5-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '80c3117cc17432043a67a73fcc9119a08c5ca4c26c530f6f181a10da03659a70',
     armv7l: '80c3117cc17432043a67a73fcc9119a08c5ca4c26c530f6f181a10da03659a70',
       i686: 'a6fb4227c591d591d61d2f61df39bcf989bcfdb6281554da7a051d392c7594f0',
     x86_64: 'df3d7a6d91af51068b9fbcbec1851f3a22a10edca341a6791262fced0a7deb36',
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
