require 'package'
Dir["#{CREW_PACKAGES_PATH}/php*.rb"].each do |phpFile|
  next unless phpFile =~ /php(\d+).rb/

  phpName = File.basename(phpFile, '.rb')
  require_relative phpName
end

class Php < Package
  description 'PHP is a popular general-purpose scripting language that is especially suited to web development.'
  homepage 'http://www.php.net/'
  key = 1
  @phpVersions = []
  Dir["#{CREW_PACKAGES_PATH}/php*.rb"].each do |phpFile|
    next unless phpFile =~ /php(\d+).rb/

    phpName = File.basename(phpFile, '.rb')
    phpVer = Object.const_get(phpName.capitalize).version.to_s.gsub(/-(\d+)/, '')
    @phpVersions.push [key, phpName, phpVer]
    @minPhpVer = phpVer if key == 1
    @maxPhpVer = phpVer
    key += 1
  end
  version "#{@minPhpVer}-#{@maxPhpVer}"
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
    @phpVersions.each do |phpVer|
      puts "#{phpVer[0]} = PHP #{phpVer[2]}"
    end
    puts '0 = Cancel'

    while version = $stdin.gets.chomp.downcase.to_i
      version = 0 if version.negative? || version > @phpVersions.length
      key = version - 1
      case version
      when @phpVersions[key][0]
        depends_on @phpVersions[key][1]
        break
      when 0
        abort
      end
    end
  end
end
