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
  php73 = `crew list installed | grep "php73" 2> /dev/null`.chomp
  php74 = `crew list installed | grep "php74" 2> /dev/null`.chomp
  depends_on 'php73' unless "#{php73}" != "" and "#{php74}" != ""

  def self.install
    system "composer install"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/phpactor"
    FileUtils.cp_r '.', "#{CREW_DEST_PREFIX}/share/phpactor/."
    FileUtils.ln_s "#{CREW_PREFIX}/share/phpactor/bin/phpactor", "#{CREW_DEST_PREFIX}/bin/phpactor"
  end

end
