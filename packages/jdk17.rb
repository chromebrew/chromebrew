require 'package'

class Jdk17 < Package
  description 'The JDK is a development environment for building applications, applets, and components using the Java programming language.'
  homepage 'https://www.oracle.com/java/technologies/downloads/#java17'
  version '17.0.3.1'
  license 'Oracle-BCLA-JavaSE'
  compatibility 'x86_64'
  source_url 'SKIP'

  no_compile_needed
  no_patchelf

  def self.preflight
    ['jdk8','jdk11','jdk15','jdk16','jdk18'].each do |jdk|
      abort "#{jdk} installed.".lightgreen if Dir.exist? "#{CREW_PREFIX}/share/#{jdk}"
    end
  end

  def self.install
    jdk_bin = "#{HOME}/Downloads/jdk-17_linux-x64_bin.tar.gz"
    jdk_sha256 = '11b4465229b77fa84416a14b5e7023b6d2cf03cda5eb1557d57aea0247fff643'
    unless File.exist? jdk_bin then
      puts "\nOracle now requires an account to download the JDK.\n".orange
      puts "You must login at https://login.oracle.com/mysso/signon.jsp and then visit:".orange
      puts "https://www.oracle.com/java/technologies/downloads/#java17".orange
      puts "\nDownload the JDK for your architecture to #{HOME}/Downloads to continue.\n".orange
      abort
    end
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read(jdk_bin) ) == jdk_sha256
    system "tar xvf #{jdk_bin}"
    jdk17_dir = "#{CREW_DEST_PREFIX}/share/jdk17"
    FileUtils.mkdir_p "#{jdk17_dir}"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.cd "jdk-#{version}" do
      FileUtils.rm_f 'lib/src.zip'
      FileUtils.mv Dir['*'], "#{jdk17_dir}/"
    end
    Dir["#{jdk17_dir}/bin/*"].each do |filename|
      binary = File.basename(filename)
      FileUtils.ln_s "#{CREW_PREFIX}/share/jdk17/bin/#{binary}", "#{CREW_DEST_PREFIX}/bin/#{binary}"
    end
    FileUtils.rm ["#{jdk17_dir}/man/man1/kinit.1", "#{jdk17_dir}/man/man1/klist.1"] # conflicts with krb5 package
    FileUtils.mv "#{jdk17_dir}/man/", "#{CREW_DEST_PREFIX}/share/"
  end
end
