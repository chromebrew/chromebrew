require 'package'

class Ant < Package
  description 'Apache Ant is a Java library and command-line tool whose mission is to drive processes described in build files as targets and extension points dependent upon each other.'
  homepage 'http://ant.apache.org/'
  version '1.10.9'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://downloads.apache.org/ant/source/apache-ant-1.10.9-src.tar.xz'
  source_sha256 '4b2008cc60fefd424b05567e9d43a071302865d5fd8b01a807e15e381b557ec2'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/ant-1.10.9-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/ant-1.10.9-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/ant-1.10.9-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/ant-1.10.9-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'e015a293ee3db3a0f4d184e0f7c07c084799013ba68912631cc2359f9f26d804',
     armv7l: 'e015a293ee3db3a0f4d184e0f7c07c084799013ba68912631cc2359f9f26d804',
       i686: '46c5120527b67417f6c2d800d5047840997f2bebec9e0dcd5aec92ed77922f9b',
     x86_64: '0599de27a4a2b30ba490319f5aa689e99feee31e5e03cb5a69f0f5c91d0e7195'
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

    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/env.d/"
    @antenv = <<~ANTEOF
      # Apache Ant configuration
      export JAVA_HOME=#{CREW_PREFIX}/share/jdk8'
      export ANT_HOME=\$JAVA_HOME
    ANTEOF
    IO.write("#{CREW_DEST_PREFIX}/etc/env.d/ant", @antenv)
  end
end
