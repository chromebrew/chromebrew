require 'package'

class Jdk8 < Package
  description 'The JDK is a development environment for building applications, applets, and components using the Java programming language.'
  homepage 'https://www.oracle.com/java/technologies/javase/javase-jdk8-downloads.html'
  version '8u333'
  license 'Oracle-BCLA-JavaSE'
  compatibility 'all'
  source_url 'SKIP'

  no_compile_needed
  no_patchelf

  def self.preflight
    ['jdk11','jdk15','jdk16','jdk17','jdk18'].each do |jdk|
      abort "#{jdk} installed.".lightgreen if Dir.exist? "#{CREW_PREFIX}/share/#{jdk}"
    end
  end

  def self.install
    case ARCH
    when 'aarch64', 'armv7l'
      jdk_bin = "#{HOME}/Downloads/jdk-#{version}-linux-arm32-vfp-hflt.tar.gz"
      jdk_sha256 = '8e42b06b7db1196d771561e1167444e29f13e8bf41adfda3e70e55c0476d900f'
    when 'i686'
      jdk_bin = "#{HOME}/Downloads/jdk-#{version}-linux-i586.tar.gz"
      jdk_sha256 = '9337ea438cf3aca880bfc9c1500fd15ce121cec1d601dd5f55baf1f7f475f0ce'
    when 'x86_64'
      jdk_bin = "#{HOME}/Downloads/jdk-#{version}-linux-x64.tar.gz"
      jdk_sha256 = '5390619a722eaccabd3b496f462b7f87cf69f98d3662fdc8452562b7bcb17e09'
    end
    unless File.exist? jdk_bin
      puts "\nOracle now requires an account to download the JDK.\n".orange
      puts "You must login at https://login.oracle.com/mysso/signon.jsp and then visit:".orange
      puts "https://www.oracle.com/java/technologies/javase/javase-jdk8-downloads.html".orange
      puts "\nDownload the JDK for your architecture to #{HOME}/Downloads to continue.\n".orange
      abort
    end
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read(jdk_bin) ) == jdk_sha256
    system "tar xvf #{jdk_bin}"
    jdk8_dir = "#{CREW_DEST_PREFIX}/share/jdk8"
    FileUtils.mkdir_p "#{jdk8_dir}"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.cd 'jdk1.8.0_333' do
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
