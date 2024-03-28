require 'package'

class Opera < Package
  description 'Opera is a multi-platform web browser based on Chromium and developed by Opera Software.'
  homepage 'https://www.opera.com/'
  version '109.0.5097.35'
  license 'OPERA-2018'
  compatibility 'x86_64'
  min_glibc '2.29'

  # faster apt mirror, but only works when downloading latest version of opera
  # source_url "https://deb.opera.com/opera/pool/non-free/o/opera-stable/opera-stable_#{version}_amd64.deb"
  source_url 'https://deb.opera.com/opera-stable/pool/non-free/o/opera-stable/opera-stable_109.0.5097.35_amd64.deb'
  source_sha256 'ac84f133856b04e703e87cd55b541472c7e05f281aaaf9a9194efd284ff27fbd'

  depends_on 'gtk3'
  depends_on 'gsettings_desktop_schemas'
  depends_on 'harfbuzz'
  depends_on 'graphite'
  depends_on 'cras'
  depends_on 'libcom_err'

  no_compile_needed
  no_shrink

  def self.install
    # Since opera puts the executable in a location that is not in the path,
    # we need to link it to bin directory.
    FileUtils.ln_sf "#{CREW_PREFIX}/share/x86_64-linux-gnu/opera/opera", 'bin/opera'

    # Move lib subfolder to the share directory.
    FileUtils.mv 'lib/x86_64-linux-gnu/', 'share/'
    FileUtils.rm_rf 'lib/'

    FileUtils.mkdir_p CREW_DEST_PREFIX
    FileUtils.mv Dir['*'], CREW_DEST_PREFIX
  end

  def self.postinstall
    puts
    print 'Set Opera as your default browser? [Y/n]: '
    case $stdin.gets.chomp.downcase
    when '', 'y', 'yes'
      Dir.chdir("#{CREW_PREFIX}/bin") do
        FileUtils.ln_sf "#{CREW_LIB_PREFIX}/opera/opera", 'x-www-browser'
      end
      puts 'Opera is now your default browser.'.lightgreen
    else
      puts 'No change has been made.'.orange
    end
    puts "\nType 'opera' to get started.\n".lightblue
  end

  def self.remove
    Dir.chdir("#{CREW_PREFIX}/bin") do
      if File.exist?('x-www-browser') && File.symlink?('x-www-browser') && \
         (File.realpath('x-www-browser') == "#{CREW_PREFIX}/share/x86_64-linux-gnu/opera/opera")
        FileUtils.rm 'x-www-browser'
      end
    end
  end
end
