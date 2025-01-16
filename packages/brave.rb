require 'package'

class Brave < Package
  description 'Next generation Brave browser for macOS, Windows, Linux, Android.'
  homepage 'https://brave.com/'
  version '1.74.48'
  license 'MPL-2'
  compatibility 'x86_64'
  min_glibc '2.29'
  source_url "https://github.com/brave/brave-browser/releases/download/v#{version}/brave-browser-#{version}-linux-amd64.zip"
  source_sha256 'bdbbaf865bb95b669eb1074de141c5b09d4e8b5b11d2d252dd2ffba93f99b7b3'

  no_compile_needed
  no_shrink

  depends_on 'gtk3'
  depends_on 'libcom_err'
  depends_on 'xdg_base'
  depends_on 'sommelier'

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/brave"
    FileUtils.cp_r '.', "#{CREW_DEST_PREFIX}/share/brave"
    FileUtils.ln_s "#{CREW_PREFIX}/share/brave/brave", "#{CREW_DEST_PREFIX}/bin/brave"
    FileUtils.ln_s CREW_LIB_PREFIX, "#{CREW_DEST_PREFIX}/share/#{ARCH_LIB}"
  end

  def self.postinstall
    print "\nSet Brave as your default browser? [Y/n]: "
    case $stdin.gets.chomp.downcase
    when '', 'y', 'yes'
      Dir.chdir("#{CREW_PREFIX}/bin") do
        FileUtils.ln_sf 'brave', 'x-www-browser'
      end
      puts 'Brave is now your default browser.'.lightgreen
    else
      puts 'No change has been made.'.orange
    end
    ExitMessage.add "\nType 'brave' to get started.\n"
  end

  def self.preremove
    Dir.chdir("#{CREW_PREFIX}/bin") do
      if File.exist?('x-www-browser') && File.symlink?('x-www-browser') && \
         File.realpath('x-www-browser') == "#{CREW_PREFIX}/share/brave/brave"
        FileUtils.rm "#{CREW_PREFIX}/bin/x-www-browser"
      end
    end
  end
end
