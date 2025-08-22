require 'package'

class Seamonkey < Package
  description 'Web-browser, advanced e-mail, newsgroup and feed client, IRC chat, and HTML editing made simple'
  homepage 'https://www.seamonkey-project.org/'
  version '2.53.21'
  license 'Mozilla Public License 2.0'
  compatibility 'x86_64'
  min_glibc '2.28'
  source_url "https://archive.seamonkey-project.org/releases/#{version}/linux-x86_64/en-US/seamonkey-#{version}.en-US.linux-x86_64.tar.bz2"
  source_sha256 'd02d1e9409a2c3b864c6f6e96436da17aafef5cd75131e08c9e93f2e5276638c'

  depends_on 'dbus_glib'
  depends_on 'gtk3'
  depends_on 'sommelier'

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/seamonkey"
    FileUtils.mv Dir['*'], "#{CREW_DEST_PREFIX}/share/seamonkey"
    FileUtils.ln_s "#{CREW_PREFIX}/share/seamonkey/seamonkey", "#{CREW_DEST_PREFIX}/bin/seamonkey"
  end

  def self.postinstall
    print "\nSet seamonkey as your default browser? [Y/n]: "
    case $stdin.gets.chomp.downcase
    when '', 'y', 'yes'
      Dir.chdir("#{CREW_PREFIX}/bin") do
        FileUtils.ln_sf 'seamonkey', 'x-www-browser'
      end
      puts 'seamonkey is now your default browser.'.lightgreen
    else
      puts 'No change has been made.'.orange
    end
    ExitMessage.add "\nType 'seamonkey' to get started.\n"
  end

  def self.postremove
    Dir.chdir("#{CREW_PREFIX}/bin") do
      if File.exist?('x-www-browser') && File.symlink?('x-www-browser') \
        && (File.realpath('x-www-browser') == "#{CREW_PREFIX}/bin/seamonkey")
        FileUtils.rm 'x-www-browser'
      end
    end
    if Dir.exist?("#{HOME}/.mozilla/firefox")
      Package.agree_to_remove("#{HOME}/.mozilla/seamonkey")
    else
      Package.agree_to_remove("#{HOME}/.mozilla")
    end
  end
end
