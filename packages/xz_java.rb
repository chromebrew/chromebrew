require 'package'

class Xz_java < Package
  description 'A complete implementation of XZ data de/compression in pure Java.'
  homepage 'http://tukaani.org/xz/java.html'
  version '1.8'
  source_url 'https://tukaani.org/xz/xz-java-1.8.zip'
  source_sha256 '86be97adf59d19c000c5bac8c77f2fa2f84fa082d608c7ad2d07a007dce76160'

  binary_url ({
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/xz_java-1.8-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     x86_64: '911b67621907a1fca84fbdf3fce3cb3910a508bdf0b73731e0bf9c9a76920c29',
  })

  depends_on 'jdk8'
  depends_on 'ant' => :build

  def self.build
    system "env", "JAVA_HOME=#{CREW_PREFIX}/share/jdk8", "ant"
    system "env", "JAVA_HOME=#{CREW_PREFIX}/share/jdk8", "ant", "doc"
    system "wget", "https://github.com/JL2210/bash-scripts/raw/94fb9fe9a69610c36de0978a1232769bb86b01a6/xz-java.in"
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read("xz-java.in") ) == '077d39e511a896f9d9db8328edbf7254c9f8c1746f1d114863422005693835e2'
    system "sed 's,@PREFIX@,#{CREW_PREFIX},g' xz-java.in > xz-java"
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/doc/xz-java-1.8/"
    system "cp", "-a", "build/doc/.", "#{CREW_DEST_PREFIX}/share/doc/xz-java-1.8/"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/jdk8/"
    system "cp", "-a", "build/jar/.", "#{CREW_DEST_PREFIX}/share/jdk8/lib/"
    system "install", "-Dm755", "xz-java", "#{CREW_DEST_PREFIX}/bin/xz-java"
  end
end
