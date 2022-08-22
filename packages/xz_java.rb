require 'package'

class Xz_java < Package
  description 'A complete implementation of XZ data de/compression in pure Java.'
  homepage 'http://tukaani.org/xz/java.html'
  version '1.9'
  license 'public-domain'
  compatibility 'all'
  source_url 'https://tukaani.org/xz/xz-java-1.9.zip'
  source_sha256 'b1d9a603f4fa75f0702ef84af5bcc11d03e721b6317daec1b1f81c31904bed00'

  depends_on 'jdk8'
  depends_on 'ant' => :build

  def self.build
    system 'env', "JAVA_HOME=#{CREW_PREFIX}/share/jdk8", 'ant'
    system 'env', "JAVA_HOME=#{CREW_PREFIX}/share/jdk8", 'ant', 'doc'
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/doc/xz-java-1.8/"
    FileUtils.cp_r 'build/doc/.', "#{CREW_DEST_PREFIX}/share/doc/xz-java-1.8/"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/jdk8/"
    FileUtils.cp_r 'build/jar/.', "#{CREW_DEST_PREFIX}/share/jdk8/lib/"
  end
end
