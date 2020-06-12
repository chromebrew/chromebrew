require 'package'

class Mysqltuner < Package
  description 'MySQLTuner is a script written in Perl that allows you to review a MySQL installation quickly and make adjustments to increase performance and stability.'
  homepage 'https://github.com/major/MySQLTuner-perl'
  version '1.7.7'
  compatibility 'all'
  source_url 'https://raw.githubusercontent.com/major/MySQLTuner-perl/1c51f442822a170fb2eaafb088f22c8f4baacd9d/README.md'
  source_sha256 '381d2200b487b4e8839d863ee300b761d5d0a8ee4eac5a8c51ef9bbd640ae6e6'

  depends_on 'perl'

  def self.install
    system "wget https://raw.githubusercontent.com/major/MySQLTuner-perl/1c51f442822a170fb2eaafb088f22c8f4baacd9d/mysqltuner.pl"
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read('mysqltuner.pl') ) == '26ad914fff4afca883a6a4d2bc69c142316144888c45e46e0fa56ad2b5a98a34'
    system "install -Dm755 mysqltuner.pl #{CREW_DEST_PREFIX}/bin/mysqltuner"
  end
end
