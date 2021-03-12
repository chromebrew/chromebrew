require 'package'

class Php < Package
  description 'PHP is a popular general-purpose scripting language that is especially suited to web development.'
  homepage 'http://www.php.net/'
  version '5.6.40-8.0.2'
  compatibility 'all'

  is_fake

  if ARGV[0] == 'install'
    phpver = `php -v 2> /dev/null | head -1 | cut -d' ' -f2`.chomp
    abort "PHP version #{phpver} already installed.".lightgreen unless "#{phpver}" == ""
    puts
    puts "Select version:"
    puts "5.6 = PHP 5.6.40"
    puts "7.1 = PHP 7.1.33"
    puts "7.2 = PHP 7.2.34"
    puts "7.3 = PHP 7.3.27"
    puts "7.4 = PHP 7.4.15"
    puts "8.0 = PHP 8.0.2"
    puts "  0 = Cancel"

    while version = STDIN.gets.chomp
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
      when '0'
        abort
        break
      else
        puts "\nPlease select from one of the options or enter 0 to cancel."
      end
    end
  end
end
