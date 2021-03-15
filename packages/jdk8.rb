require 'package'

class Jdk8 < Package
  description 'The JDK is a development environment for building applications, applets, and components using the Java programming language.'
  homepage 'https://www.oracle.com/java/technologies/javase/javase-jdk8-downloads.html'
  version '8u281'
  compatibility 'all'
  source_url 'file:///dev/null'
  source_sha256 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/jdk8-8u281-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/jdk8-8u281-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/jdk8-8u281-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/jdk8-8u281-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'cd7eaa50a24c5fd23a3239955b4e8d307269265f83cac4b6c5d0b8c034db95f0',
     armv7l: 'cd7eaa50a24c5fd23a3239955b4e8d307269265f83cac4b6c5d0b8c034db95f0',
       i686: '1875067e9c3d376a7823260508cf9ec9f0413a0328fc53d045389f5f064adc9f',
     x86_64: '22a574bf80181b74b09256bd4832db6e7bb4bab688ab139e27ad90237a58322e',
  })

  def self.preflight
    abort "JDK11 installed.".lightgreen if Dir.exists? "#{CREW_PREFIX}/share/jdk11"
    abort "JDK15 installed.".lightgreen if Dir.exists? "#{CREW_PREFIX}/share/jdk15"
  end

  def self.install
    case ARCH
    when 'aarch64', 'armv7l'
      jdk_bin = "#{HOME}/Downloads/jdk-#{version}-linux-arm32-vfp-hflt.tar.gz"
      jdk_sha256 = 'a176d6f216717ac0eac15efd00d07849d9d2ef53b9d5902929b421aaae22fc43'
    when 'i686'
      jdk_bin = "#{HOME}/Downloads/jdk-#{version}-linux-i586.tar.gz"
      jdk_sha256 = 'ff2118e4ee8c60dca34b9612199b60c9d6fcb61ea31d02cdbc8f6d34f221dfed'
    when 'x86_64'
      jdk_bin = "#{HOME}/Downloads/jdk-#{version}-linux-x64.tar.gz"
      jdk_sha256 = '85e8c7da7248c7450fb105567a78841d0973597850776c24a527feb02ef3e586'
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
    FileUtils.cd 'jdk1.8.0_281' do
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
