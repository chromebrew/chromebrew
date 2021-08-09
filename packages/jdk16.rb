require 'package'

class Jdk16 < Package
  description 'The JDK is a development environment for building applications, applets, and components using the Java programming language.'
  homepage 'https://www.oracle.com/java/technologies/javase-jdk16-downloads.html'
  version '16.0.2'
  license 'Oracle-BCLA-JavaSE'
  compatibility 'x86_64'
  source_url 'SKIP'

  binary_url ({
    x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/jdk16/16.0.2_x86_64/jdk16-16.0.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    x86_64: '7acd295a21ee61486b1ef0baef3eaee1978d296d10cf1f767a0266fabb5c74f5',
  })

  def self.preflight
    abort "JDK8 installed.".lightgreen if Dir.exists? "#{CREW_PREFIX}/share/jdk8"
    abort "JDK11 installed.".lightgreen if Dir.exists? "#{CREW_PREFIX}/share/jdk11"
    abort "JDK15 installed.".lightgreen if Dir.exists? "#{CREW_PREFIX}/share/jdk15"
  end

  def self.install
    jdk_bin = "#{HOME}/Downloads/jdk-#{version}_linux-x64_bin.tar.gz"
    jdk_sha256 = '630e3e56c58f45db3788343ce842756d5a5a401a63884242cc6a141071285a62'
    unless File.exists? jdk_bin then
      puts
      puts "Oracle now requires an account to download the JDK.".orange
      puts
      puts "You must login at https://login.oracle.com/mysso/signon.jsp and then visit:".orange
      puts "https://www.oracle.com/java/technologies/javase-jdk16-downloads.html".orange
      puts
      puts "Download the JDK for your architecture to #{HOME}/Downloads to continue.".orange
      puts
      abort
    end
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read(jdk_bin) ) == jdk_sha256
    system "tar xvf #{jdk_bin}"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/jdk16"
    FileUtils.mkdir_p "#{CREW_DEST_MAN_PREFIX}/man1"
    FileUtils.cd "jdk-#{version}" do
      FileUtils.rm_f 'lib/src.zip'
      FileUtils.mv Dir['*'], "#{CREW_DEST_PREFIX}/share/jdk16/"
    end
    FileUtils.cd "#{CREW_DEST_PREFIX}/share/jdk16/bin" do
      system "find -type f -exec ln -s #{CREW_PREFIX}/share/jdk16/bin/{} #{CREW_DEST_PREFIX}/bin/{} \\;"
    end
    FileUtils.rm "#{CREW_DEST_PREFIX}/share/jdk16/man/man1/kinit.1" # conflict with krb5 package
    FileUtils.rm "#{CREW_DEST_PREFIX}/share/jdk16/man/man1/klist.1" # conflict with krb5 package
    system "compressdoc --gzip -9 #{CREW_DEST_PREFIX}/share/jdk16/man/man1"
    FileUtils.cd "#{CREW_DEST_PREFIX}/share/jdk16/man/man1" do
      system "find -type f -exec ln -s #{CREW_PREFIX}/share/jdk16/man/man1/{} #{CREW_DEST_MAN_PREFIX}/man1/{} \\;"
    end
  end
end
