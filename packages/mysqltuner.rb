require 'package'

class Mysqltuner < Package
  description 'MySQLTuner is a script written in Perl that allows you to review a MySQL installation quickly and make adjustments to increase performance and stability.'
  homepage 'https://github.com/major/MySQLTuner-perl'
  version '2.6.0'
  license 'GPL-3+'
  compatibility 'all'
  source_url 'https://github.com/major/MySQLTuner-perl.git'
  git_hashtag "v#{version}"

  depends_on 'perl'

  no_compile_needed

  def self.patch
    system "sed -i '1i#!#{CREW_PREFIX}/bin/perl' mysqltuner.pl"
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.install 'mysqltuner.pl', "#{CREW_DEST_PREFIX}/share/mysqltuner/mysqltuner.pl", mode: 0o755
    FileUtils.install 'basic_passwords.txt', "#{CREW_DEST_PREFIX}/share/mysqltuner/basic_passwords.txt", mode: 0o644
    FileUtils.install 'vulnerabilities.csv', "#{CREW_DEST_PREFIX}/share/mysqltuner/vulnerabilities.csv", mode: 0o644
    FileUtils.ln_s "#{CREW_PREFIX}/share/mysqltuner/mysqltuner.pl", "#{CREW_DEST_PREFIX}/bin/mysqltuner"
  end
end
