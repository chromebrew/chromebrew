require 'package'

class Ant < Package
  description 'Apache Ant is a Java library and command-line tool whose mission is to drive processes described in build files as targets and extension points dependent upon each other.'
  homepage 'https://ant.apache.org/'
  version '1.10.18'
  license 'Apache-2.0'
  compatibility 'all'
  source_url "https://downloads.apache.org/ant/source/apache-ant-#{version}-src.tar.xz"
  source_sha256 '89779e1d1288baa10687a2f1f7cdb6e9a666839a971a0c502a0c6b11bc061629'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0c1548f11cd0911575aead01499edf07d55e8089c51c0b0027c1927080929bf4',
     armv7l: '0c1548f11cd0911575aead01499edf07d55e8089c51c0b0027c1927080929bf4',
       i686: 'cd46382104849df14084858e99179963cbd6e00e48ad6aa2dc2a0ce0a5b6a173',
     x86_64: '9a6e8dba35adc4453d80c02246d487cde796a3e204f4bd665823a5d6009c451b'
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
