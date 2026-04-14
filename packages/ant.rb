require 'package'

class Ant < Package
  description 'Apache Ant is a Java library and command-line tool whose mission is to drive processes described in build files as targets and extension points dependent upon each other.'
  homepage 'https://ant.apache.org/'
  version '1.10.17'
  license 'Apache-2.0'
  compatibility 'all'
  source_url "https://downloads.apache.org/ant/source/apache-ant-#{version}-src.tar.xz"
  source_sha256 'a2f44dff642b5490c3a728aaf7474486c9edf87da63f5ccbfda803f1e10ae7a6'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fcaf05a6797376dc308bfeaa4788c72003fbf670401d44383984dbb255088eb5',
     armv7l: 'fcaf05a6797376dc308bfeaa4788c72003fbf670401d44383984dbb255088eb5',
       i686: 'd894863652447c4f8199fc1426ca8e82e51055f4a252538c572c38fc2dbd0b2b',
     x86_64: '8c56ae059d09a60816cacb3a9d40c1f0a4c6069a92c1837374d6c56c2b0d1a34'
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
