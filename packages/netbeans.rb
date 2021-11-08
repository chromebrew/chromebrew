require 'package'

class Netbeans < Package
  description 'Apache NetBeans IDE is free open source software to quickly and easily develop desktop, mobile, and web applications with Java, JavaScript, HTML5, PHP, C/C++ and more.'
  homepage 'https://netbeans.org/'
  version '12.5'
  license 'Apache-2.0, custom, EPL-1.0, W3C, MIT, BSD, MPL-1.0, CC-BY-3.0, CDDL and CDDL-1.1'
  compatibility 'all'
  source_url 'https://dlcdn.apache.org/netbeans/netbeans/12.5/netbeans-12.5-bin.zip'
  source_sha256 '37c21ef64f849733cf606b9f2bcdbcddbcc6919dd3b281fd8da9e3e224d83679'

  depends_on 'jdk8'
  depends_on 'sommelier'

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/netbeans"
    FileUtils.rm Dir['bin/*.exe']
    FileUtils.mv Dir['*'], "#{CREW_DEST_PREFIX}/share/netbeans"
    FileUtils.ln_s "#{CREW_PREFIX}/share/netbeans/bin/netbeans", "#{CREW_DEST_PREFIX}/bin/netbeans"
  end

  def self.postinstall
    puts "\nType 'netbeans' to get started.\n".lightblue
  end

  def self.remove
    config_dir = "#{HOME}/.netbeans"
    if Dir.exists? config_dir
      print "Would you like to remove the config directory #{config_dir}? [y/N] "
      case STDIN.getc
      when 'y', 'Y'
        FileUtils.rm_rf config_dir
        puts "#{config_dir} removed.".lightred
      else
        puts "#{config_dir} saved.".lightgreen
      end
    end
  end
end
