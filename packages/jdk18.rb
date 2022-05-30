require 'package'

class Jdk18 < Package
  description 'The JDK is a development environment for building applications, applets, and components using the Java programming language.'
  homepage 'https://www.oracle.com/java/technologies/downloads/#java18'
  version '18.0.1.1'
  license 'Oracle-BCLA-JavaSE'
  compatibility 'x86_64'
  source_url 'SKIP'

  no_compile_needed
  no_patchelf

  def self.preflight
    ['jdk8','jdk11','jdk15','jdk16','jdk17'].each do |jdk|
      abort "#{jdk} installed.".lightgreen if Dir.exist? "#{CREW_PREFIX}/share/#{jdk}"
    end
  end

  def self.install
    jdk_bin = "#{HOME}/Downloads/jdk-18_linux-x64_bin.tar.gz"
    jdk_sha256 = 'dbabd3f726775a63329254b001b4190c082206e38323950b2db478606f1d65fa'
    unless File.exist? jdk_bin then
      puts "\nOracle now requires an account to download the JDK.\n".orange
      puts "You must login at https://login.oracle.com/mysso/signon.jsp and then visit:".orange
      puts "https://www.oracle.com/java/technologies/downloads/#java18".orange
      puts "\nDownload the JDK for your architecture to #{HOME}/Downloads to continue.\n".orange
      abort
    end
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read(jdk_bin) ) == jdk_sha256
    system "tar xvf #{jdk_bin}"
    jdk18_dir = "#{CREW_DEST_PREFIX}/share/jdk18"
    FileUtils.mkdir_p "#{jdk18_dir}"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.cd "jdk-#{version}" do
      FileUtils.rm_f 'lib/src.zip'
      FileUtils.mv Dir['*'], "#{jdk18_dir}/"
    end
    Dir["#{jdk18_dir}/bin/*"].each do |filename|
      binary = File.basename(filename)
      FileUtils.ln_s "#{CREW_PREFIX}/share/jdk18/bin/#{binary}", "#{CREW_DEST_PREFIX}/bin/#{binary}"
    end
    FileUtils.rm ["#{jdk18_dir}/man/man1/kinit.1", "#{jdk18_dir}/man/man1/klist.1"] # conflicts with krb5 package
    FileUtils.mv "#{jdk18_dir}/man/", "#{CREW_DEST_PREFIX}/share/"
  end
end
