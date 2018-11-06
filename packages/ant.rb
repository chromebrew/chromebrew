require 'package'

class Ant < Package
  description 'Apache Ant is a Java library and command-line tool whose mission is to drive processes described in build files as targets and extension points dependent upon each other.'
  homepage 'http://ant.apache.org/'
  version '1.10.5'
  source_url 'http://www.apache.org/dist/ant/source/apache-ant-1.10.5-src.tar.xz'
  source_sha256 'ec7c704e22a2b0167e1ff35cc3d4198267e6489f142aa3e9da1b7fe6e39ff53d'

  binary_url ({
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/ant-1.10.5-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     x86_64: '569b2e3a067b1a9a6b683ae6b7916130c2e3eafaf626d0e90805fc30d7695d09',
  })

  depends_on 'jdk8'

  def self.build
    system "./build.sh"
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
