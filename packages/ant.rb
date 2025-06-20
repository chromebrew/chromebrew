require 'package'

class Ant < Package
  description 'Apache Ant is a Java library and command-line tool whose mission is to drive processes described in build files as targets and extension points dependent upon each other.'
  homepage 'https://ant.apache.org/'
  version '1.10.15'
  license 'Apache-2.0'
  compatibility 'all'
  source_url "https://downloads.apache.org/ant/source/apache-ant-#{version}-src.tar.xz"
  source_sha256 '6c6e4c15233cb7b9851283051f99a9f04aa0e3291375138ea50399717d489878'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6b8e1787b8d544328024ddfea56e78cc8ce765473fd6fd3e1e7dcd7a03f62b4c',
     armv7l: '6b8e1787b8d544328024ddfea56e78cc8ce765473fd6fd3e1e7dcd7a03f62b4c',
       i686: 'cd8a568925785eaf3332db34df8ae3ae2ca3bbfae0a16d4dda27c34c4c57e3f1',
     x86_64: 'fb4b5be76ab5d62cbc56888b97dce5fac1eedf47c210b60dfb4c733d85f3f065'
  })

  depends_on 'openjdk17'

  no_fhs

  def self.build
    system "JAVA_HOME=#{CREW_PREFIX} ./build.sh"
  end

  def self.install
    # Copy lib and bin files to JAVA_HOME.
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/jre/"
    %w[lib bin].each do |dir|
      FileUtils.cp_r "dist/#{dir}/", "#{CREW_DEST_PREFIX}/jre/", preserve: true
    end

    # Symlink bin files to a directory in PATH.
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin/"
    %w[ant antRun antRun.pl complete-ant-cmd.pl runant.pl runant.py].each do |bin|
      FileUtils.ln_s "../jre/bin/#{bin}", "#{CREW_DEST_PREFIX}/bin/"
    end

    # Remove Windows executables.
    FileUtils.rm Dir["#{CREW_DEST_PREFIX}/jre/bin/*.bat"]
    FileUtils.rm Dir["#{CREW_DEST_PREFIX}/jre/bin/*.cmd"]

    # Add environment variables.
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/env.d/"
    @antenv = <<~ANTEOF
      # Apache Ant configuration
      export ANT_HOME=#{CREW_PREFIX}/jre
    ANTEOF
    File.write("#{CREW_DEST_PREFIX}/etc/env.d/10-ant", @antenv)
  end
end
