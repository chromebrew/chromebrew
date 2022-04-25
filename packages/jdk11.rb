require 'package'

class Jdk11 < Package
  description 'The JDK is a development environment for building applications, applets, and components using the Java programming language.'
  homepage 'https://www.oracle.com/java/technologies/javase-jdk11-downloads.html'
  version '11.0.15'
  license 'Oracle-BCLA-JavaSE'
  compatibility 'x86_64'
  source_url 'SKIP'

  binary_url ({
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/jdk11/11.0.15_x86_64/jdk11-11.0.15-chromeos-x86_64.tar.zst',
  })
  binary_sha256 ({
     x86_64: 'afe982bf92cc93d9c9463f0229e5b4122fc2d8340c348404bb0255ef477b84b8',
  })

  no_patchelf

  def self.preflight
    abort "JDK8 installed.".lightgreen if Dir.exist? "#{CREW_PREFIX}/share/jdk8"
    abort "JDK15 installed.".lightgreen if Dir.exist? "#{CREW_PREFIX}/share/jdk15"
    abort "JDK16 installed.".lightgreen if Dir.exist? "#{CREW_PREFIX}/share/jdk16"
    abort "JDK17 installed.".lightgreen if Dir.exist? "#{CREW_PREFIX}/share/jdk17"
    abort "JDK18 installed.".lightgreen if Dir.exist? "#{CREW_PREFIX}/share/jdk18"
  end

  def self.install
    jdk_bin = "#{HOME}/Downloads/jdk-#{version}_linux-x64_bin.tar.gz"
    jdk_sha256 = 'd69e577d6ea80bea71d01db1d17c1e764ad65982942991f4641bc63202a495ba'
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
    Dir["#{jdk11_dir}/bin/*"].each do |filename|
      binary = File.basename(filename)
      FileUtils.ln_s "#{CREW_PREFIX}/share/jdk11/bin/#{binary}", "#{CREW_DEST_PREFIX}/bin/#{binary}"
    end
    FileUtils.rm ["#{jdk11_dir}/man/man1/kinit.1", "#{jdk11_dir}/man/man1/klist.1"] # conflicts with krb5 package
    FileUtils.mv "#{jdk11_dir}/man/", "#{CREW_DEST_PREFIX}/share/"
  end
end
