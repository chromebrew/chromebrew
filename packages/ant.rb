require 'package'

class Ant < Package
  description 'Apache Ant is a Java library and command-line tool whose mission is to drive processes described in build files as targets and extension points dependent upon each other.'
  homepage 'http://ant.apache.org/'
  version '1.10.10'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://downloads.apache.org/ant/source/apache-ant-1.10.10-src.tar.xz'
  source_sha256 'c8ab046eaca09d2c3fa0cdf1a681740e31f8afad0ad6bc346fe51d16fdc6d92d'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ant/1.10.10_armv7l/ant-1.10.10-chromeos-armv7l.tpxz',
    armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ant/1.10.10_armv7l/ant-1.10.10-chromeos-armv7l.tpxz',
    i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ant/1.10.10_i686/ant-1.10.10-chromeos-i686.tpxz',
    x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ant/1.10.10_x86_64/ant-1.10.10-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '0cd248d2aad662ee194c4da645a2de61757dc3e3fe2f1fa962cb08a5cc7c9df8',
    armv7l: '0cd248d2aad662ee194c4da645a2de61757dc3e3fe2f1fa962cb08a5cc7c9df8',
    i686: '41f67696a66bd3e812bd232eda0e3c499d11075b189364109ade3fb5e3737823',
    x86_64: '3583405dbe2ea4233533f00e492140bfc48478e3d0024be3c9f98e372c6defaf'
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
      export JAVA_HOME=#{CREW_PREFIX}/share/jdk8
      export ANT_HOME=\$JAVA_HOME
    ANTEOF
    IO.write("#{CREW_DEST_PREFIX}/etc/env.d/ant", @antenv)
  end
end
