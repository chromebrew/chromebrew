require 'package'

class Netbeans < Package
  description 'Apache NetBeans IDE is free open source software to quickly and easily develop desktop, mobile, and web applications with Java, JavaScript, HTML5, PHP, C/C++ and more.'
  homepage 'https://netbeans.org/'
  version '12.0-1'
  compatibility 'all'
  source_url 'http://www.gtlib.gatech.edu/pub/apache/netbeans/netbeans/12.0/netbeans-12.0-bin.zip'
  source_sha256 '85d91529c18f672322af58d21cae853178d574dd35d53a6cfe45992b99c64545'

  depends_on 'jdk8'
  depends_on 'sommelier'

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/netbeans"
    FileUtils.rm Dir.glob('bin/*.exe')
    FileUtils.mv Dir.glob('*'), "#{CREW_DEST_PREFIX}/share/netbeans"
    FileUtils.ln_s "#{CREW_PREFIX}/share/netbeans/bin/netbeans", "#{CREW_DEST_PREFIX}/bin/netbeans"
  end

  def self.postinstall
    puts
    puts "Type 'netbeans' to get started.".lightblue
    puts
    puts "To remove, including all plugins and preferences, execute the following:".lightblue
    puts "crew remove netbeans".lightblue
    puts "rm -rf ~/.netbeans".lightblue
    puts
  end
end
