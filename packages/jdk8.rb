require 'package'

class Jdk8 < Package
  description 'The JDK is a development environment for building applications, applets, and components using the Java programming language.'
  homepage 'https://www.oracle.com/java/technologies/javase/javase-jdk8-downloads.html'
  version '8u321'
  license 'Oracle-BCLA-JavaSE'
  compatibility 'all'
  source_url 'SKIP'

  binary_url ({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/jdk8/8u321_armv7l/jdk8-8u321-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/jdk8/8u321_armv7l/jdk8-8u321-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/jdk8/8u321_i686/jdk8-8u321-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/jdk8/8u321_x86_64/jdk8-8u321-chromeos-x86_64.tpxz',
  })
  binary_sha256 ({
    aarch64: '9d82b73079cd534ea25d2fd6e11f278dbb75f228386e41056af590148291b572',
     armv7l: '9d82b73079cd534ea25d2fd6e11f278dbb75f228386e41056af590148291b572',
       i686: '9d82b73079cd534ea25d2fd6e11f278dbb75f228386e41056af590148291b572',
     x86_64: '9f98ab42cfbb44dab60f5f0e42899c8383b50e3a739d2fe76c73025f451b6df3',
  })

  def self.preflight
    abort "JDK11 installed.".lightgreen if Dir.exists? "#{CREW_PREFIX}/share/jdk11"
    abort "JDK15 installed.".lightgreen if Dir.exists? "#{CREW_PREFIX}/share/jdk15"
    abort "JDK16 installed.".lightgreen if Dir.exists? "#{CREW_PREFIX}/share/jdk16"
    abort "JDK17 installed.".lightgreen if Dir.exists? "#{CREW_PREFIX}/share/jdk17"
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
      jdk_sha256 = '7262e6c7cf8cc8f2a9a5982edc26fa3025aa60101902424619c3bb0cff9bd89f'
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
    jdk8_dir = "#{CREW_DEST_PREFIX}/share/jdk8"
    FileUtils.mkdir_p "#{jdk8_dir}"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.cd 'jdk1.8.0_321' do
      FileUtils.rm_f 'src.zip'
      FileUtils.rm_f 'javafx-src.zip'
      FileUtils.cp_r Dir['*'], "#{jdk8_dir}/"
    end
    FileUtils.cd "#{jdk8_dir}/bin" do
      system "find -type f -exec ln -s #{jdk8_dir}/bin/{} #{CREW_DEST_PREFIX}/bin/{} \\;"
    end
    FileUtils.mv "#{jdk8_dir}/man/", "#{CREW_DEST_PREFIX}/share/"
  end
end
