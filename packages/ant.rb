require 'package'

class Ant < Package
  description 'Apache Ant is a Java library and command-line tool whose mission is to drive processes described in build files as targets and extension points dependent upon each other.'
  homepage 'http://ant.apache.org/'
  version '1.10.7-1'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://www.apache.org/dist/ant/source/apache-ant-1.10.7-src.tar.xz'
  source_sha256 'c8d68b396d9e44b49668bafe0c82f8c89497915254b5395d73d6f6e41d7a0e25'

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

    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/env.d/"
    @env = <<~EOF
      # Apache Ant configuration
      export JAVA_HOME=#{CREW_PREFIX}/share/jdk8'
      export ANT_HOME=$JAVA_HOME
    EOF
    IO.write("#{CREW_DEST_PREFIX}/etc/env.d/ant", @env)
  end
end
