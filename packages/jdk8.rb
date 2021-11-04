require 'package'

class Jdk8 < Package
  description 'The JDK is a development environment for building applications, applets, and components using the Java programming language.'
  homepage 'https://www.oracle.com/java/technologies/javase/javase-jdk8-downloads.html'
  version '8u311'
  license 'Oracle-BCLA-JavaSE'
  compatibility 'all'
  source_url 'SKIP'

  binary_url ({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/jdk8/8u311_armv7l/jdk8-8u311-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/jdk8/8u311_armv7l/jdk8-8u311-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/jdk8/8u311_i686/jdk8-8u311-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/jdk8/8u311_x86_64/jdk8-8u311-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '08748bcb7746a701b9181b00f9661f41228a89a859f75738edab9ea3a0fc0254',
     armv7l: '08748bcb7746a701b9181b00f9661f41228a89a859f75738edab9ea3a0fc0254',
       i686: '84d5315cfa1a3a65982a64028bc375601d41fd816187cd1476a75405296e2426',
     x86_64: '9da28fdda2374b4449e23b4909910b5ac24ad05ff60c9fc9ff26ba15346343bf',
  })

  def self.preflight
    abort "JDK11 installed.".lightgreen if Dir.exists? "#{CREW_PREFIX}/share/jdk11"
    abort "JDK15 installed.".lightgreen if Dir.exists? "#{CREW_PREFIX}/share/jdk15"
    abort "JDK16 installed.".lightgreen if Dir.exists? "#{CREW_PREFIX}/share/jdk16"
  end

  def self.install
    case ARCH
    when 'aarch64', 'armv7l'
      jdk_bin = "#{HOME}/Downloads/jdk-#{version}-linux-arm32-vfp-hflt.tar.gz"
      jdk_sha256 = 'd0748f7197fc49a73e50320699f1de4d3d3cd269bb4bdeb7dfd0a418ccfc1788'
    when 'i686'
      jdk_bin = "#{HOME}/Downloads/jdk-#{version}-linux-i586.tar.gz"
      jdk_sha256 = '42d9a2a66db962f205f370167625235b1624afb18c56198158a519b63cba835e'
    when 'x86_64'
      jdk_bin = "#{HOME}/Downloads/jdk-#{version}-linux-x64.tar.gz"
      jdk_sha256 = '759823389014292e84742a226b0e8fbaa08efa32adc6e6435a690c5576df3bb4'
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
    FileUtils.cd 'jdk1.8.0_311' do
      FileUtils.rm_f 'src.zip'
      FileUtils.rm_f 'javafx-src.zip'
      FileUtils.cp_r Dir['*'], "#{CREW_DEST_PREFIX}/share/jdk8/"
    end
    FileUtils.cd "#{CREW_DEST_PREFIX}/share/jdk8/bin" do
      system "find -type f -exec ln -s #{CREW_PREFIX}/share/jdk8/bin/{} #{CREW_DEST_PREFIX}/bin/{} \\;"
    end
    FileUtils.mv "#{CREW_DEST_PREFIX}/share/jdk8/man/", "#{CREW_DEST_PREFIX}/share/"
  end
end
