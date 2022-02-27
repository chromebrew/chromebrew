require 'package'

class Mysqltuner < Package
  description 'MySQLTuner is a script written in Perl that allows you to review a MySQL installation quickly and make adjustments to increase performance and stability.'
  homepage 'https://github.com/major/MySQLTuner-perl'
  version '1.8.3'
  license 'GPL-3+'
  compatibility 'all'
  source_url 'https://github.com/major/MySQLTuner-perl/archive/1.8.3.tar.gz'
  source_sha256 '9b8b1dff03550f03c659d2b850cb287d784f0d79f193c1d8a969516cc44738cb'

  depends_on 'perl'

  def self.patch
    system "sed -i 's,/usr/bin/env perl,#{CREW_PREFIX}/bin/perl,' mysqltuner.pl"
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/mysqltuner"
    FileUtils.install 'mysqltuner.pl', "#{CREW_DEST_PREFIX}/share/mysqltuner/mysqltuner.pl", mode: 0o755
    FileUtils.install 'basic_passwords.txt', "#{CREW_DEST_PREFIX}/share/mysqltuner/basic_passwords.txt", mode: 0o644
    FileUtils.install 'vulnerabilities.csv', "#{CREW_DEST_PREFIX}/share/mysqltuner/vulnerabilities.csv", mode: 0o644
    FileUtils.ln_s "#{CREW_PREFIX}/share/mysqltuner/mysqltuner.pl", "#{CREW_DEST_PREFIX}/bin/mysqltuner"
  end
end
