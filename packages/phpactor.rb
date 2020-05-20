require 'package'

class Phpactor < Package
  description 'PHP completion, refactoring and introspection tool.'
  homepage 'https://phpactor.readthedocs.io/en/develop/'
  version '0.15.0'
  source_url 'https://github.com/phpactor/phpactor/archive/0.15.0.tar.gz'
  source_sha256 '02f63e77aa435874a3e8ef11a293eb24a7ee259317dfaae3f058d8bc24e39e24'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'composer'
  
  phpMinimalVersion = "7.3"
  phpDefaultVersion = "7.4"
  phpver = `php -v 2> /dev/null | head -1 | cut -d' ' -f2`.chomp
  if (ARGV[0] == 'install' || ARGV[0] == 'reinstall' || ARGV[0] == 'upgrade') && ARGV[1] == 'phpactor'
    if "#{phpver}" == ""
      depends_on "php"+"#{phpDefaultVersion}".split(".").take(2).join
    elsif Gem::Version.new("#{phpver}") >= Gem::Version.new("#{phpMinimalVersion}")
      depends_on "php"+"#{phpver}".split(".").take(2).join
    else
      abort "Minimum version of php73 required".lightred 
    end
  end


  def self.install
    system "composer install"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/phpactor"
    FileUtils.cp_r '.', "#{CREW_DEST_PREFIX}/share/phpactor/."
    FileUtils.ln_s "#{CREW_PREFIX}/share/phpactor/bin/phpactor", "#{CREW_DEST_PREFIX}/bin/phpactor"
  end

end
