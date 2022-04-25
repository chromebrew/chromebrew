require 'package'

class Jdk8 < Package
  description 'The JDK is a development environment for building applications, applets, and components using the Java programming language.'
  homepage 'https://www.oracle.com/java/technologies/javase/javase-jdk8-downloads.html'
  version '8u331'
  license 'Oracle-BCLA-JavaSE'
  compatibility 'all'
  source_url 'SKIP'

  binary_url ({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/jdk8/8u331_armv7l/jdk8-8u331-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/jdk8/8u331_armv7l/jdk8-8u331-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/jdk8/8u331_i686/jdk8-8u331-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/jdk8/8u331_x86_64/jdk8-8u331-chromeos-x86_64.tar.zst',
  })
  binary_sha256 ({
    aarch64: '1793fe2d3e4b8e0ebaefb8a3ea70c74e0c2ea60685c35658f5aa543487076d0d',
     armv7l: '1793fe2d3e4b8e0ebaefb8a3ea70c74e0c2ea60685c35658f5aa543487076d0d',
       i686: '6202cf6bd725a694af3ce170db4b03c97b7cb0d090f4304abbd639b9425cdbc9',
     x86_64: 'e2afb6dcbbe6ae7154e2cd1c112dbbf6055fa4b6063daf560a597064b8511b5d',
  })

  no_patchelf

  def self.preflight
    abort "JDK11 installed.".lightgreen if Dir.exist? "#{CREW_PREFIX}/share/jdk11"
    abort "JDK15 installed.".lightgreen if Dir.exist? "#{CREW_PREFIX}/share/jdk15"
    abort "JDK16 installed.".lightgreen if Dir.exist? "#{CREW_PREFIX}/share/jdk16"
    abort "JDK17 installed.".lightgreen if Dir.exist? "#{CREW_PREFIX}/share/jdk17"
    abort "JDK18 installed.".lightgreen if Dir.exist? "#{CREW_PREFIX}/share/jdk18"
  end

  def self.install
    case ARCH
    when 'aarch64', 'armv7l'
      jdk_bin = "#{HOME}/Downloads/jdk-#{version}-linux-arm32-vfp-hflt.tar.gz"
      jdk_sha256 = '83bcb32b3f52e57aab425e22e35e28b49a81477a21bf184ed0ef1bc74f1a3e16'
    when 'i686'
      jdk_bin = "#{HOME}/Downloads/jdk-#{version}-linux-i586.tar.gz"
      jdk_sha256 = '525ef1c399b3a7f7255f9e1e9a3d1044b56a40d4d2cae2775e819c1173b8ec5d'
    when 'x86_64'
      jdk_bin = "#{HOME}/Downloads/jdk-#{version}-linux-x64.tar.gz"
      jdk_sha256 = '272a4ceb76bf286b40eb07d581a8d134f6be5fb5f646cb25c2212b1e7779bb91'
    end
    unless File.exist? jdk_bin
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
    jdk8_dir = "#{CREW_DEST_PREFIX}/share/jdk8"
    FileUtils.mkdir_p "#{jdk8_dir}"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.cd 'jdk1.8.0_331' do
      FileUtils.rm_f 'src.zip'
      FileUtils.rm_f 'javafx-src.zip'
      FileUtils.cp_r Dir['*'], "#{jdk8_dir}/"
    end
    Dir["#{jdk8_dir}/bin/*"].each do |filename|
      binary = File.basename(filename)
      FileUtils.ln_s "#{CREW_PREFIX}/share/jdk8/bin/#{binary}", "#{CREW_DEST_PREFIX}/bin/#{binary}"
    end
    FileUtils.mv "#{jdk8_dir}/man/", "#{CREW_DEST_PREFIX}/share/"
  end
end
