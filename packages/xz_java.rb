require 'package'

class Xz_java < Package
  description 'A complete implementation of XZ data de/compression in pure Java.'
  homepage 'http://tukaani.org/xz/java.html'
  version '1.8-1'
  source_url 'https://tukaani.org/xz/xz-java-1.8.zip'
  source_sha256 '86be97adf59d19c000c5bac8c77f2fa2f84fa082d608c7ad2d07a007dce76160'

  depends_on 'jdk8'
  depends_on 'ant' => :build

  def self.build
    system "env", "JAVA_HOME=#{CREW_PREFIX}/share/jdk8", "ant"
    system "env", "JAVA_HOME=#{CREW_PREFIX}/share/jdk8", "ant", "doc"
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/doc/xz-java-1.8/"
    system "cp", "-a", "build/doc/.", "#{CREW_DEST_PREFIX}/share/doc/xz-java-1.8/"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/jdk8/"
    system "cp", "-a", "build/jar/.", "#{CREW_DEST_PREFIX}/share/jdk8/lib/"
  end
end
