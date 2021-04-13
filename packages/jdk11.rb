require 'package'

class Jdk11 < Package
  description 'The JDK is a development environment for building applications, applets, and components using the Java programming language.'
  homepage 'https://www.oracle.com/java/technologies/javase-jdk11-downloads.html'
  version '11.0.10'
  license 'Oracle-BCLA-JavaSE'
  compatibility 'x86_64'
  source_url 'file:///dev/null'
  source_sha256 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855'

  binary_url ({
    x86_64: 'https://downloads.sourceforge.net/project/chromebrew/x86_64/jdk11-11.0.10-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    x86_64: '6082f18263db0ded42b64130948c8dc39564aadd726c79f6ba92038566120107',
  })

  def self.preflight
    abort "JDK8 installed.".lightgreen if Dir.exists? "#{CREW_PREFIX}/share/jdk8"
    abort "JDK15 installed.".lightgreen if Dir.exists? "#{CREW_PREFIX}/share/jdk15"
  end

  def self.install
    jdk_bin = "#{HOME}/Downloads/jdk-#{version}_linux-x64_bin.tar.gz"
    jdk_sha256 = '94bd34f85ee38d3ef59e5289ec7450b9443b924c55625661fffe66b03f2c8de2'
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
