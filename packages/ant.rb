require 'package'

class Ant < Package
  description 'Apache Ant is a Java library and command-line tool whose mission is to drive processes described in build files as targets and extension points dependent upon each other.'
  homepage 'http://ant.apache.org/'
  version '1.10.14'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://downloads.apache.org/ant/source/apache-ant-1.10.14-src.tar.xz'
  source_sha256 '9eea3cd8a793574a07fde2f87b203dc86339492baeb539367d5aa5be497aea24'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ant/1.10.14_armv7l/ant-1.10.14-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ant/1.10.14_armv7l/ant-1.10.14-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ant/1.10.14_i686/ant-1.10.14-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ant/1.10.14_x86_64/ant-1.10.14-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '467ba617135bbe2ba177bacbe2c98b9a520361b21d14b3e2508acee527c9f588',
     armv7l: '467ba617135bbe2ba177bacbe2c98b9a520361b21d14b3e2508acee527c9f588',
       i686: '979f1f0284376f53b341b8d3e015ce5bc0d425931590e5a6bde21b9de87157c2',
     x86_64: '2763cdc4ddd5fa2a1b71f766302204f30814fad4a82528e09f947a779bc5da1a'
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
