require 'package'

class Rkhunter < Package
  description 'Rootkit Hunter, security monitoring and analyzing tool for POSIX compliant systems.'
  homepage 'http://rkhunter.sourceforge.net/'
  version '1.4.6'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://downloads.sourceforge.net/project/rkhunter/rkhunter/1.4.6/rkhunter-1.4.6.tar.gz'
  source_sha256 'f750aa3e22f839b637a073647510d7aa3adf7496e21f3c875b7a368c71d37487'

  no_compile_needed

  def self.patch
    system "sed -i 's,\"/usr/local\",\"#{CREW_DEST_PREFIX}\",g' installer.sh"
    system "sed -i 's,\"/etc\",\"#{CREW_DEST_PREFIX}/etc\",g' installer.sh"
    system "sed -i 's,\"/var\",\"#{CREW_DEST_PREFIX}/var\",g' installer.sh"
  end

  def self.install
    FileUtils.mkdir_p CREW_DEST_PREFIX
    system './installer.sh --install'
    system "sed -i 's,#{CREW_DEST_PREFIX},#{CREW_PREFIX},g' #{CREW_DEST_PREFIX}/etc/rkhunter.conf"
  end

  def self.postinstall
    puts "\nTo run a check without prompting for a keypress after each test, execute the following:".lightblue
    puts "sudo rkhunter -c --sk\n".lightblue
  end
end
