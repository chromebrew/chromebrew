require 'package'

class Xz_java < Package
  description 'A complete implementation of XZ data de/compression in pure Java.'
  homepage 'http://tukaani.org/xz/java.html'
  version '1.8'
  source_url 'https://tukaani.org/xz/xz-java-1.8.zip'
  source_sha256 '86be97adf59d19c000c5bac8c77f2fa2f84fa082d608c7ad2d07a007dce76160'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/xz_java-1.8-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/xz_java-1.8-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/xz_java-1.8-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/xz_java-1.8-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '927cfb38e52c280911da4d872725adabb5ccdb441e6ba6e863a9b0749949c8d2',
     armv7l: '927cfb38e52c280911da4d872725adabb5ccdb441e6ba6e863a9b0749949c8d2',
       i686: '86f8b69472e938a45ca86748e9807d16d1cbe533702d46e172a1c14e8e8c24ef',
     x86_64: 'eb2980fe8486f6ecc571eb194368bd354bd544ec7f035bd4177bfdb68c239b74',
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
