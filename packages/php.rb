require 'package'

class Php < Package
  description 'PHP is a popular general-purpose scripting language that is especially suited to web development.'
  homepage 'http://www.php.net/'
  version '5.6.40-8.2.4'
  license 'PHP-3.01'
  compatibility 'all'

  is_fake

  def self.preflight
    major = `php -v 2> /dev/null | head -1 | cut -d' ' -f2 | cut -d'.' -f1`.chomp
    minor = `php -v 2> /dev/null | head -1 | cut -d' ' -f2 | cut -d'.' -f2`.chomp
    unless major.empty? && minor.empty?
      puts "Php#{major}#{minor} already installed.".lightgreen
      abort "Enter `crew remove php#{major}#{minor} && crew install php` to install a different version."
    end
    puts
    puts 'Select version:'
    puts '5.6 = PHP 5.6.40'
    puts '7.1 = PHP 7.1.33'
    puts '7.2 = PHP 7.2.34'
    puts '7.3 = PHP 7.3.33'
    puts '7.4 = PHP 7.4.33'
    puts '8.0 = PHP 8.0.28'
    puts '8.1 = PHP 8.1.17'
    puts '8.2 = PHP 8.2.4'
    puts '  0 = Cancel'

    while version = $stdin.gets.chomp.downcase
      case version
      when '5.6'
        depends_on 'php5'
        break
      when '7.1'
        depends_on 'php71'
        break
      when '7.2'
        depends_on 'php72'
        break
      when '7.3'
        depends_on 'php73'
        break
      when '7.4'
        depends_on 'php74'
        break
      when '8.0'
        depends_on 'php80'
        break
      when '8.1'
        depends_on 'php81'
        break
      when '8.2'
        depends_on 'php82'
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
