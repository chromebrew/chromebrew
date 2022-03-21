require 'package'

class Jdk11 < Package
  description 'The JDK is a development environment for building applications, applets, and components using the Java programming language.'
  homepage 'https://www.oracle.com/java/technologies/javase-jdk11-downloads.html'
  version '11.0.14-1'
  license 'Oracle-BCLA-JavaSE'
  compatibility 'x86_64'
  source_url 'SKIP'

  binary_url ({
    x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/jdk11/11.0.14_x86_64/jdk11-11.0.14-chromeos-x86_64.tar.zst',
  })
  binary_sha256 ({
    x86_64: '43d59131a67913446b6193f7cd65243eee7576f2d41f058721f87ca5214d7227',
  })

  def self.preflight
    abort "JDK8 installed.".lightgreen if Dir.exists? "#{CREW_PREFIX}/share/jdk8"
    abort "JDK15 installed.".lightgreen if Dir.exists? "#{CREW_PREFIX}/share/jdk15"
    abort "JDK16 installed.".lightgreen if Dir.exists? "#{CREW_PREFIX}/share/jdk16"
    abort "JDK17 installed.".lightgreen if Dir.exists? "#{CREW_PREFIX}/share/jdk17"
  end

  def self.install
    jdk_bin = "#{HOME}/Downloads/jdk-#{version}_linux-x64_bin.tar.gz"
    jdk_sha256 = '9732bdd946b393ec527e4d5ff1f7e4667dc5150685bc3c9c7b1d042c657929db'
    unless File.exist? jdk_bin then
      puts
      puts "Oracle now requires an account to download the JDK.".orange
      puts
      puts "You must login at https://login.oracle.com/mysso/signon.jsp and then visit:".orange
      puts "https://www.oracle.com/java/technologies/javase-jdk11-downloads.html".orange
      puts
      puts "Download the JDK for your architecture to #{HOME}/Downloads to continue.".orange
      puts
      abort
    end
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read(jdk_bin) ) == jdk_sha256
    system "tar xvf #{jdk_bin}"
    jdk11_dir = "#{CREW_DEST_PREFIX}/share/jdk11"
    FileUtils.mkdir_p "#{jdk11_dir}"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.cd "jdk-#{version}" do
      FileUtils.rm_f 'lib/src.zip'
      FileUtils.mv Dir['*'], "#{jdk11_dir}/"
    end
    FileUtils.cd "#{jdk11_dir}/bin" do
      system "find -type f -exec ln -s #{CREW_PREFIX}/share/jdk11/bin/{} #{CREW_DEST_PREFIX}/bin/{} \\;"
    end
  end
end
