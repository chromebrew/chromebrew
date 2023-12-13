require 'package'

class Opera < Package
  description 'Opera is a multi-platform web browser based on Chromium and developed by Opera Software.'
  homepage 'https://www.opera.com/'
  version '105.0.4970.48'
  license 'OPERA-2018'
  compatibility 'x86_64'

  # faster apt mirror, but only works when downloading latest version of opera
  # source_url "https://deb.opera.com/opera/pool/non-free/o/opera-stable/opera-stable_#{version}_amd64.deb"
  source_url "https://get.opera.com/pub/opera/desktop/#{version}/linux/opera-stable_#{version}_amd64.deb"
  source_sha256 'e1f3ca1ad86b7941a5d6c6632e510ef1f93cf4467c575c42339a9fb4f8c441c2'

  depends_on 'gtk3'
  depends_on 'gsettings_desktop_schemas'
  depends_on 'harfbuzz'
  depends_on 'graphite'
  depends_on 'cras'
  depends_on 'libcom_err'

  no_compile_needed
  no_shrink

  def self.preflight
    if Gem::Version.new(LIBC_VERSION.to_s) < Gem::Version.new('2.29')
      puts "\nOpera requires GLIBC 2.29 and above.".lightred
      abort "ChromeOS is currently running GLIBC #{LIBC_VERSION}.\n".lightred
    end
  end

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
