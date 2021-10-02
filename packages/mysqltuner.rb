require 'package'

class Mysqltuner < Package
  description 'MySQLTuner is a script written in Perl that allows you to review a MySQL installation quickly and make adjustments to increase performance and stability.'
  homepage 'https://github.com/major/MySQLTuner-perl'
  version '1.7.21'
  license 'GPL-3+'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'perl'

  def self.install
    system "curl -#LO https://raw.githubusercontent.com/major/MySQLTuner-perl/1.7.21/mysqltuner.pl"
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read('mysqltuner.pl') ) == 'dd982083478a604ca0ada434b1b7d0323aa7c8302f4731d25a93cf0f77c46a27'
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.install 'mysqltuner.pl', "#{CREW_DEST_PREFIX}/bin/mysqltuner", mode: 0o755
  end
end
