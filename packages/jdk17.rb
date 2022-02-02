require 'package'

class Jdk17 < Package
  description 'The JDK is a development environment for building applications, applets, and components using the Java programming language.'
  homepage 'https://www.oracle.com/java/technologies/downloads/#java17'
  version '17.0.2'
  license 'Oracle-BCLA-JavaSE'
  compatibility 'x86_64'
  source_url 'SKIP'

  binary_url ({
    x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/jdk17/17.0.2_x86_64/jdk17-17.0.2-chromeos-x86_64.tpxz',
  })
  binary_sha256 ({
    x86_64: '971c5890446de2fa514a16fe925be6162947e2639cd3d6d3b11287ac18dbd89d',
  })

  def self.preflight
    abort "JDK8 installed.".lightgreen if Dir.exists? "#{CREW_PREFIX}/share/jdk8"
    abort "JDK11 installed.".lightgreen if Dir.exists? "#{CREW_PREFIX}/share/jdk11"
    abort "JDK15 installed.".lightgreen if Dir.exists? "#{CREW_PREFIX}/share/jdk15"
    abort "JDK16 installed.".lightgreen if Dir.exists? "#{CREW_PREFIX}/share/jdk16"
  end

  def self.install
    jdk_bin = "#{HOME}/Downloads/jdk-17_linux-x64_bin.tar.gz"
    jdk_sha256 = '342e76bb9ded80aa1edd566efbae42f8f1c2366e19b9189e5941b45893b9861f'
    unless File.exists? jdk_bin then
      puts
      puts "Oracle now requires an account to download the JDK.".orange
      puts
      puts "You must login at https://login.oracle.com/mysso/signon.jsp and then visit:".orange
      puts "https://www.oracle.com/java/technologies/downloads/#java17".orange
      puts
      puts "Download the JDK for your architecture to #{HOME}/Downloads to continue.".orange
      puts
      abort
    end
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read(jdk_bin) ) == jdk_sha256
    system "tar xvf #{jdk_bin}"
    jdk17_dir = "#{CREW_DEST_PREFIX}/share/jdk17"
    FileUtils.mkdir_p "#{jdk17_dir}"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_MAN_PREFIX}/man1"
    FileUtils.cd "jdk-#{version}" do
      FileUtils.rm_f 'lib/src.zip'
      FileUtils.mv Dir['*'], "#{jdk17_dir}/"
    end
    FileUtils.cd "#{jdk17_dir}/bin" do
      system "find -type f -exec ln -s #{jdk17_dir}/bin/{} #{CREW_DEST_PREFIX}/bin/{} \\;"
    end
    FileUtils.rm "#{jdk17_dir}/man/man1/kinit.1" # conflict with krb5 package
    FileUtils.rm "#{jdk17_dir}/man/man1/klist.1" # conflict with krb5 package
    system "compressdoc --gzip -9 #{jdk17_dir}/man/man1"
    FileUtils.cd "#{jdk17_dir}/man/man1" do
      system "find -type f -exec ln -s #{jdk17_dir}/man/man1/{} #{CREW_DEST_MAN_PREFIX}/man1/{} \\;"
    end
  end
end
