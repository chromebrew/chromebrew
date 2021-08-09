require 'package'

class Jdk11 < Package
  description 'The JDK is a development environment for building applications, applets, and components using the Java programming language.'
  homepage 'https://www.oracle.com/java/technologies/javase-jdk11-downloads.html'
  version '11.0.12'
  license 'Oracle-BCLA-JavaSE'
  compatibility 'x86_64'
  source_url 'SKIP'

  binary_url ({
    x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/jdk11/11.0.12_x86_64/jdk11-11.0.12-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    x86_64: '09c96d97915b7f31c8b0c2655e4bf1d342dcb2638b825cb497276c58ae5a0dff',
  })

  def self.preflight
    abort "JDK8 installed.".lightgreen if Dir.exists? "#{CREW_PREFIX}/share/jdk8"
    abort "JDK15 installed.".lightgreen if Dir.exists? "#{CREW_PREFIX}/share/jdk15"
  end

  def self.install
    jdk_bin = "#{HOME}/Downloads/jdk-#{version}_linux-x64_bin.tar.gz"
    jdk_sha256 = 'd5d45826f835bd1ea069f9ff8bcd0f23c9f05c8d063b7df821960cfa765ed2cb'
    unless File.exists? jdk_bin then
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
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/jdk11"
    FileUtils.cd "jdk-#{version}" do
      FileUtils.rm_f 'lib/src.zip'
      FileUtils.mv Dir.glob('*'), "#{CREW_DEST_PREFIX}/share/jdk11/"
    end
    FileUtils.cd "#{CREW_DEST_PREFIX}/share/jdk11/bin" do
      system "find -type f -exec ln -s #{CREW_PREFIX}/share/jdk11/bin/{} #{CREW_DEST_PREFIX}/bin/{} \\;"
    end
  end
end
