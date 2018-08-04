require 'package'

class Ant < Package
  description 'Apache Ant is a Java library and command-line tool whose mission is to drive processes described in build files as targets and extension points dependent upon each other.'
  homepage 'http://ant.apache.org/'
  version '1.10.5'
  source_url 'https://www.apache.org/dist/ant/source/apache-ant-1.10.5-src.tar.xz'
  source_sha256 'ec7c704e22a2b0167e1ff35cc3d4198267e6489f142aa3e9da1b7fe6e39ff53d'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'jdk8'

  def self.install
  ENV['JAVA_HOME'] = "#{CREW_PREFIX}/share/jdk8"
    system "./bootstrap.sh"
    system "rm -f", 
	    "lib/README bootstrap/bin/*.cmd", 
	    "bootstrap/bin/*.bat"
    Dir.chdir ("bootstrap/bin") do
      system "sed -i 's:/usr/bin/perl:#{CREW_PREFIX}/bin/perl:g' antRun.pl"
      system "sed -i 's:/usr/bin/perl:#{CREW_PREFIX}/bin/perl:g' complete-ant-cmd.pl"
      system "sed -i 's:/usr/bin/perl:#{CREW_PREFIX}/bin/perl:g' runant.pl"
      system "sed -i 's:/usr/bin/python:#{CREW_PREFIX}/bin/python2.7:g' runant.py"
    end
    system "mv build.xml bootstrap/bin/"
    system "mkdir -p #{CREW_DEST_PREFIX}"
    system "mkdir -p #{CREW_DEST_LIB_PREFIX}"
    system "cp -rpa bootstrap/bin #{CREW_DEST_PREFIX}"
    system "cp -rpa lib/* #{CREW_DEST_LIB_PREFIX}"
    system "cp -rpa bootstrap/lib/* #{CREW_DEST_LIB_PREFIX}"
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
