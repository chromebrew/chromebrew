require 'package'

class Mysqltuner < Package
  description 'MySQLTuner is a script written in Perl that allows you to review a MySQL installation quickly and make adjustments to increase performance and stability.'
  homepage 'https://github.com/major/MySQLTuner-perl'
  version '2.2.12'
  license 'GPL-3+'
  compatibility 'all'
  source_url 'https://github.com/major/MySQLTuner-perl/archive/v2.2.12.tar.gz'
  source_sha256 '51d7f569ec2fde5ffbe38731e79c8b113899bbf5ea200fc407c622a359b2cca4'

  depends_on 'perl'

  no_compile_needed

  def self.patch
    system "sed -i 's,2\.2\.9,#{version},g' mysqltuner.pl"
    system "sed -i 's,/usr/bin/env perl,#{CREW_PREFIX}/bin/perl,' mysqltuner.pl"
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.install 'mysqltuner.pl', "#{CREW_DEST_PREFIX}/share/mysqltuner/mysqltuner.pl", mode: 0o755
    FileUtils.install 'basic_passwords.txt', "#{CREW_DEST_PREFIX}/share/mysqltuner/basic_passwords.txt", mode: 0o644
    FileUtils.install 'vulnerabilities.csv', "#{CREW_DEST_PREFIX}/share/mysqltuner/vulnerabilities.csv", mode: 0o644
    FileUtils.ln_s "#{CREW_PREFIX}/share/mysqltuner/mysqltuner.pl", "#{CREW_DEST_PREFIX}/bin/mysqltuner"
  end
end
