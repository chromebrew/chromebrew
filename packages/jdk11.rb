require 'package'

class Jdk11 < Package
  description 'The JDK is a development environment for building applications, applets, and components using the Java programming language.'
  homepage 'https://www.oracle.com/java/technologies/javase-jdk11-downloads.html'
  version '11.0.15.1'
  license 'Oracle-BCLA-JavaSE'
  compatibility 'x86_64'
  source_url 'SKIP'

  no_compile_needed
  no_patchelf

  def self.preflight
    ['jdk8','jdk15','jdk16','jdk17','jdk18'].each do |jdk|
      abort "#{jdk} installed.".lightgreen if Dir.exist? "#{CREW_PREFIX}/share/#{jdk}"
    end
  end

  def self.install
    jdk_bin = "#{HOME}/Downloads/jdk-#{version}_linux-x64_bin.tar.gz"
    jdk_sha256 = 'a40ad9342646ec14196deaf28c64f697fef4c698296f0e7d39b638f360780d27'
    unless File.exist? jdk_bin then
      puts "\nOracle now requires an account to download the JDK.\n".orange
      puts "You must login at https://login.oracle.com/mysso/signon.jsp and then visit:".orange
      puts "https://www.oracle.com/java/technologies/downloads/#java11".orange
      puts "\nDownload the JDK for your architecture to #{HOME}/Downloads to continue.\n".orange
      abort
    end
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read(jdk_bin) ) == jdk_sha256
    system "tar xvf #{jdk_bin}"
    jdk11_dir = "#{CREW_DEST_PREFIX}/share/jdk11"
    FileUtils.mkdir_p "#{jdk11_dir}"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.cd "jdk-#{version}" do
      FileUtils.rm_f 'lib/src.zip'
      FileUtils.mv Dir['*'], "#{jdk11_dir}/"
    end
    Dir["#{jdk11_dir}/bin/*"].each do |filename|
      binary = File.basename(filename)
      FileUtils.ln_s "#{CREW_PREFIX}/share/jdk11/bin/#{binary}", "#{CREW_DEST_PREFIX}/bin/#{binary}"
    end
    FileUtils.rm ["#{jdk11_dir}/man/man1/kinit.1", "#{jdk11_dir}/man/man1/klist.1"] # conflicts with krb5 package
    FileUtils.mv "#{jdk11_dir}/man/", "#{CREW_DEST_PREFIX}/share/"
  end
end
