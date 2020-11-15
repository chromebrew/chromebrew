require 'package'

class Jdk8 < Package
  description 'The JDK is a development environment for building applications, applets, and components using the Java programming language.'
  homepage 'https://www.oracle.com/java/technologies/javase/javase-jdk8-downloads.html'
  version '8u271'
  compatibility 'all'
  source_url 'file:///dev/null'
  source_sha256 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/jdk8-8u271-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/jdk8-8u271-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/jdk8-8u271-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/jdk8-8u271-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '705ab1be8b97058d347ec9b318fb2a61279f24b7419f8741355c0affeedbdd44',
     armv7l: '705ab1be8b97058d347ec9b318fb2a61279f24b7419f8741355c0affeedbdd44',
       i686: '808513e7e6edfd62846707f707a9cc958f19604fcae83ceaa9751ecdc9465534',
     x86_64: '881a2ad3bd6855cb03f410e9d73674d9ae876de9d223702ee0634cda6f99cf5b',
  })

  case ARGV[0]
  when 'install', 'reinstall'
    abort "JDK11 installed.".lightgreen if Dir.exists? "#{CREW_PREFIX}/share/jdk11"
  end

  def self.install
    case ARCH
    when 'aarch64', 'armv7l'
      jdk_bin = "#{HOME}/Downloads/jdk-#{version}-linux-arm32-vfp-hflt.tar.gz"
      jdk_sha256 = '619297d2251fef2a94054865a47b55758c3a0c112eec4fe96df7157caec73313'
    when 'i686'
      jdk_bin = "#{HOME}/Downloads/jdk-#{version}-linux-i586.tar.gz"
      jdk_sha256 = '9c2d5b4530e3d013d6a8294b09f348a9d527f47cb0505f19fe9215f4aab72c6d'
    when 'x86_64'
      jdk_bin = "#{HOME}/Downloads/jdk-#{version}-linux-x64.tar.gz"
      jdk_sha256 = 'eba7926a683bb65c6f4e1c502ce624346c42b00fb5531deba296f2560b452c78'
    end
    unless File.exists? jdk_bin
      puts
      puts "Oracle now requires an account to download the JDK.".orange
      puts
      puts "You must login at https://login.oracle.com/mysso/signon.jsp and then visit:".orange
      puts "https://www.oracle.com/java/technologies/javase/javase-jdk8-downloads.html".orange
      puts
      puts "Download the JDK for your architecture to #{HOME}/Downloads to continue.".orange
      puts
      abort
    end
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read(jdk_bin) ) == jdk_sha256
    system "tar xvf #{jdk_bin}"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/jdk8"
    FileUtils.cd 'jdk1.8.0_271' do
      FileUtils.rm_f 'src.zip'
      FileUtils.rm_f 'javafx-src.zip'
      FileUtils.cp_r Dir.glob('*'), "#{CREW_DEST_PREFIX}/share/jdk8/"
    end
    FileUtils.cd "#{CREW_DEST_PREFIX}/share/jdk8/bin" do
      system "find -type f -exec ln -s #{CREW_PREFIX}/share/jdk8/bin/{} #{CREW_DEST_PREFIX}/bin/{} \\;"
    end
    FileUtils.mv "#{CREW_DEST_PREFIX}/share/jdk8/man/", "#{CREW_DEST_PREFIX}/share/"
  end
end
