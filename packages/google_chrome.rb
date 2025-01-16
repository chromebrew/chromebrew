require 'package'

class Google_chrome < Package
  @update_channel = 'stable'
  description 'Google Chrome is a fast, easy to use, and secure web browser.'
  homepage 'https://www.google.com/chrome/'
  version '132.0.6834.83-1'
  license 'google-chrome'
  compatibility 'x86_64'
  min_glibc '2.28'
  source_url "https://dl.google.com/linux/chrome/deb/pool/main/g/google-chrome-#{@update_channel}/google-chrome-#{@update_channel}_#{@version}_amd64.deb"
  source_sha256 'aae7efee6ee243cc97e9678d6a34db3c42c299186be061816bc5b3cbe88c1618'

  depends_on 'nss'
  depends_on 'cairo'
  depends_on 'gtk3'
  depends_on 'expat'
  depends_on 'cras'

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"

    FileUtils.mv 'usr/share', CREW_DEST_PREFIX
    FileUtils.mv 'opt/google/chrome', "#{CREW_DEST_PREFIX}/share"

    FileUtils.ln_s "#{CREW_PREFIX}/share/chrome/google-chrome", "#{CREW_DEST_PREFIX}/bin/google-chrome"
  end

  def self.postinstall
    print "\nSet Chrome as your default browser? [Y/n]: "
    case $stdin.gets.chomp.downcase
    when '', 'y', 'yes'
      Dir.chdir("#{CREW_PREFIX}/bin") do
        FileUtils.ln_sf 'google-chrome', 'x-www-browser'
      end
      puts 'Chrome is now your default browser.'.lightgreen
    else
      puts 'No change has been made.'.orange
    end
    ExitMessage.add "\nType 'google-chrome' to get started.\n"
  end

  def self.preremove
    Dir.chdir("#{CREW_PREFIX}/bin") do
      if File.exist?('x-www-browser') && File.symlink?('x-www-browser') && \
         File.realpath('x-www-browser') == "#{CREW_PREFIX}/share/chrome/google-chrome"
        FileUtils.rm "#{CREW_PREFIX}/bin/x-www-browser"
      end
    end
  end
end
