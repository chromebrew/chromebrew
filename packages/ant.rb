require 'package'

class Ant < Package
  description 'Apache Ant is a Java library and command-line tool whose mission is to drive processes described in build files as targets and extension points dependent upon each other.'
  homepage 'https://ant.apache.org/'
  version '1.10.16'
  license 'Apache-2.0'
  compatibility 'all'
  source_url "https://downloads.apache.org/ant/source/apache-ant-#{version}-src.tar.xz"
  source_sha256 'ade2bd5be495853bb9437a7b19eb31d0c51b5a7722e0064105484273fa7242fb'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '91026af350c5487a4f84feee24a02007657b04c3183f5d9cccfd652285d591b5',
     armv7l: '91026af350c5487a4f84feee24a02007657b04c3183f5d9cccfd652285d591b5',
       i686: 'aaccc317852b71dd9323d1a390746e1333d9d944c359133b7a3e782696efb324',
     x86_64: 'e04a5b0f5bbed1438d31bc0ba074884cf542981cce173718c69da95392465969'
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
