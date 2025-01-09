require 'package'

class Mullvad < Package
  description 'Privacy-focused browser'
  homepage 'https://mullvad.net/browser'
  version '14.0.4'
  license 'Mozilla Public License V2'
  compatibility 'x86_64'
  source_url "https://github.com/mullvad/mullvad-browser/releases/download/#{version}/mullvad-browser-linux-x86_64-#{version}.tar.xz"
  source_sha256 '6359a228bbd56a0115c8c783c8632e936898a93ddde9ff67c66dfd4463cfcc33'

  depends_on 'gtk3'
  depends_on 'gdk_base'

  no_compile_needed
  no_shrink
  print_source_bashrc

  def self.patch
    system "sed -i 's,\",,g' Browser/start-mullvad-browser.desktop"
    system "sed -i 's,\\$(dirname \\$\\*)/Browser,#{CREW_PREFIX}/share/mullvad,g' Browser/start-mullvad-browser.desktop"
    system "sed -i 's,\\$(dirname \\$\\*),#{CREW_PREFIX}/share/mullvad,g' Browser/start-mullvad-browser.desktop"
    system "sed -i 's,./Browser,#{CREW_PREFIX}/share/mullvad,g' Browser/start-mullvad-browser.desktop"
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/mullvad"
    FileUtils.install 'Browser/start-mullvad-browser.desktop', "#{CREW_DEST_PREFIX}/share/applications/start-mullvad-browser.desktop", mode: 0o644
    FileUtils.install 'Browser/browser/chrome/icons/default/default64.png', "#{CREW_DEST_PREFIX}/share/icons/default/64x64/apps/web-browser.png", mode: 0o644
    FileUtils.ln_s "#{CREW_PREFIX}/share/mullvad/start-mullvad-browser", "#{CREW_DEST_PREFIX}/bin/mullvad"
    FileUtils.mv Dir['Browser/*'], "#{CREW_DEST_PREFIX}/share/mullvad"
  end

  def self.postinstall
    print "\nSet Mullvad as your default browser? [Y/n]: "
    case $stdin.gets.chomp.downcase
    when '', 'y', 'yes'
      Dir.chdir("#{CREW_PREFIX}/bin") do
        FileUtils.ln_sf 'mullvad', 'x-www-browser'
      end
      puts 'Mullvad is now your default browser.'.lightgreen
    else
      puts 'No change has been made.'.orange
    end
    puts "\nType 'mullvad' to get started.\n".lightblue
  end

  def self.postremove
    Dir.chdir("#{CREW_PREFIX}/bin") do
      if File.exist?('x-www-browser') && File.symlink?('x-www-browser') \
        && (File.realpath('x-www-browser') == "#{CREW_PREFIX}/bin/mullvad")
        FileUtils.rm 'x-www-browser'
      end
    end
    Package.agree_to_remove("#{CREW_PREFIX}/share/mullvad")
  end
end
