require 'package'

class Ant < Package
  description 'Apache Ant is a Java library and command-line tool whose mission is to drive processes described in build files as targets and extension points dependent upon each other.'
  homepage 'http://ant.apache.org/'
  version '1.10.13'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://downloads.apache.org/ant/source/apache-ant-1.10.13-src.tar.xz'
  source_sha256 '2a3de6f5d52f7859e0a18f23d8dcdd64cde05ed262654b2286f74759cf0d68d4'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ant/1.10.13_armv7l/ant-1.10.13-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ant/1.10.13_armv7l/ant-1.10.13-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ant/1.10.13_i686/ant-1.10.13-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ant/1.10.13_x86_64/ant-1.10.13-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '7efecd6f69bcd03f99fd44bc1c372a459cd4af8a733ef704c56c4d3f7c2be867',
     armv7l: '7efecd6f69bcd03f99fd44bc1c372a459cd4af8a733ef704c56c4d3f7c2be867',
       i686: '5d31e55569623b7c12f3e9e610d22bbfdb2c95ed755181876e77e35486c513e8',
     x86_64: '6f77e95af8b964dd1083f94a23b8088ac016f3d50a9319b79aaf7631860c09a9'
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
    FileUtils.rm "#{CREW_DEST_PREFIX}/jre/bin/*.{bat,cmd}"

    # Add environment variables.
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/env.d/"
    @antenv = <<~ANTEOF
      # Apache Ant configuration
      export ANT_HOME=#{CREW_PREFIX}/jre
    ANTEOF
    File.write("#{CREW_DEST_PREFIX}/etc/env.d/10-ant", @antenv)
  end
end
