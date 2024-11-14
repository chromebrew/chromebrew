require 'package'
Dir["#{CREW_PACKAGES_PATH}/php*.rb"].each do |php_file|
  next unless php_file =~ /php(\d+).rb/

  php_name = File.basename(php_file, '.rb')
  require_relative php_name
end

class Php < Package
  description 'PHP is a popular general-purpose scripting language that is especially suited to web development.'
  homepage 'http://www.php.net/'
  key = 1
  @php_versions = []
  Dir["#{CREW_PACKAGES_PATH}/php*.rb"].each do |php_file|
    next unless php_file =~ /php(\d+).rb/

    php_name = File.basename(php_file, '.rb')
    php_ver = Object.const_get(php_name.capitalize).version.to_s.gsub(/-(\d+)/, '')
    @php_versions.push [key, php_name, php_ver]
    @min_php_ver = php_ver if key == 1
    @max_php_ver = php_ver
    key += 1
  end
  version "#{@min_php_ver}-#{@max_php_ver}"
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
    puts "\nSelect version:"
    @php_versions.each do |php_ver|
      puts "#{php_ver[0]} = PHP #{php_ver[2]}"
    end
    puts '0 = Cancel'

    while (version = $stdin.gets.chomp.downcase.to_i)
      version = 0 if version.negative? || version > @php_versions.length
      key = version - 1
      case version
      when @php_versions[key][0]
        depends_on @php_versions[key][1]
        break
      when 0
        abort
      end
    end
  end
end
