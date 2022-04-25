require 'package'

class Jdk18 < Package
  description 'The JDK is a development environment for building applications, applets, and components using the Java programming language.'
  homepage 'https://www.oracle.com/java/technologies/downloads/#java18'
  version '18.0.1'
  license 'Oracle-BCLA-JavaSE'
  compatibility 'x86_64'
  source_url 'SKIP'

  binary_url ({
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/jdk18/18.0.1_x86_64/jdk18-18.0.1-chromeos-x86_64.tar.zst',
  })
  binary_sha256 ({
     x86_64: '96af8a414a2b175eed412a32ac6dd478cf17f1231de53ecff2f8a329e8a30ab7',
  })

  no_patchelf

  def self.preflight
    abort "JDK8 installed.".lightgreen if Dir.exist? "#{CREW_PREFIX}/share/jdk8"
    abort "JDK11 installed.".lightgreen if Dir.exist? "#{CREW_PREFIX}/share/jdk11"
    abort "JDK15 installed.".lightgreen if Dir.exist? "#{CREW_PREFIX}/share/jdk15"
    abort "JDK16 installed.".lightgreen if Dir.exist? "#{CREW_PREFIX}/share/jdk16"
    abort "JDK17 installed.".lightgreen if Dir.exist? "#{CREW_PREFIX}/share/jdk17"
  end

  def self.install
    jdk_bin = "#{HOME}/Downloads/jdk-18_linux-x64_bin.tar.gz"
    jdk_sha256 = '15f017ea76d7bb9da2e4c25097d515f1a6181f7e857f86919721fe760a19ff56'
    unless File.exist? jdk_bin then
      puts
      puts "Oracle now requires an account to download the JDK.".orange
      puts
      puts "You must login at https://login.oracle.com/mysso/signon.jsp and then visit:".orange
      puts "https://www.oracle.com/java/technologies/downloads/#java18".orange
      puts
      puts "Download the JDK for your architecture to #{HOME}/Downloads to continue.".orange
      puts
      abort
    end
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read(jdk_bin) ) == jdk_sha256
    system "tar xvf #{jdk_bin}"
    jdk18_dir = "#{CREW_DEST_PREFIX}/share/jdk18"
    FileUtils.mkdir_p "#{jdk18_dir}"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.cd "jdk-#{version}" do
      FileUtils.rm_f 'lib/src.zip'
      FileUtils.mv Dir['*'], "#{jdk18_dir}/"
    end
    Dir["#{jdk18_dir}/bin/*"].each do |filename|
      binary = File.basename(filename)
      FileUtils.ln_s "#{CREW_PREFIX}/share/jdk18/bin/#{binary}", "#{CREW_DEST_PREFIX}/bin/#{binary}"
    end
    FileUtils.rm ["#{jdk18_dir}/man/man1/kinit.1", "#{jdk18_dir}/man/man1/klist.1"] # conflicts with krb5 package
    FileUtils.mv "#{jdk18_dir}/man/", "#{CREW_DEST_PREFIX}/share/"
  end
end
