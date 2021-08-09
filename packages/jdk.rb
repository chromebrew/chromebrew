require 'package'

class Jdk < Package
  description 'The JDK is a development environment for building applications, applets, and components using the Java programming language.'
  homepage 'https://www.oracle.com/java/technologies/javase/javase-jdk8-downloads.html'
  version '8u301-16.0.2'
  license 'Oracle-BCLA-JavaSE'
  compatibility 'all'

  is_fake

  def self.preflight
    jdkver = `java -version 2>&1 | head -1 | cut -d'"' -f2`.chomp
    unless jdkver.empty? or jdkver.include? 'No such file or directory' or jdkver.include? 'not found'
      majver = `java -version 2>&1 | head -1 | cut -d'"' -f2 | cut -d'.' -f1`.chomp
      majver = '8' if majver == '1'
      puts "Package jdk#{majver} already installed.".lightgreen
      abort "Enter `crew remove jdk#{majver} && crew install jdk` to install a different version."
    end
    puts
    puts "Select version:"
    puts " 8 = JDK 8u301"
    if ARCH == 'x86_64'
      puts "11 = JDK 11.0.12"
      puts "15 = JDK 15.0.2"
      puts "16 = JDK 16.0.2"
    end
    puts " 0 = Cancel"

    while version = STDIN.gets.chomp
      case version
      when '8', '11', '15', '16'
        depends_on 'jdk' + version
        break
      when '0'
        abort
        break
      else
        puts "\nPlease select from one of the options or enter 0 to cancel."
      end
    end
  end
end
