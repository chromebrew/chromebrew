require 'package'

class Ant < Package
  description 'Apache Ant is a Java library and command-line tool whose mission is to drive processes described in build files as targets and extension points dependent upon each other.'
  homepage 'http://ant.apache.org/'
  version '1.10.12'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://downloads.apache.org/ant/source/apache-ant-1.10.12-src.tar.xz'
  source_sha256 '7629bb10285c5de609df56ae9bc968332f3d34d6cd5c0a5dffe24078e09e98b3'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ant/1.10.12_armv7l/ant-1.10.12-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ant/1.10.12_armv7l/ant-1.10.12-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ant/1.10.12_i686/ant-1.10.12-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ant/1.10.12_x86_64/ant-1.10.12-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '9dc7ee71af5a01d4296f10088f85f56eaaa7fee7ce2e17d2fec333b3e695e85e',
     armv7l: '9dc7ee71af5a01d4296f10088f85f56eaaa7fee7ce2e17d2fec333b3e695e85e',
       i686: '4d395d93af5b3d4593ca5f5a63c7afb6c024fd20a195da0d821c91941b952de6',
     x86_64: '54e4732e54364e068ae90a953ef80364e099bf5523208c1e03c7ab1ef0ad2b65'
  })

  depends_on 'openjdk8'

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
