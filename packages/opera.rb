require 'package'

class Opera < Package
  description "Opera is a multi-platform web browser based on Chromium and developed by Opera Software."
  homepage 'https://www.opera.com/'
  version '75.0.3969.171'
  license 'OPERA-2018'
  compatibility 'x86_64'
  source_url "https://get.geo.opera.com/pub/opera/desktop/#{version}/linux/opera-stable_#{version}_amd64.deb"
  source_sha256 '7ce460d2c53dbefb83106d90812f60e36e09165548dcb0907f52b44bd66b8039'

  depends_on 'gtk3'
  depends_on 'gsettings_desktop_schemas'
  depends_on 'harfbuzz'
  depends_on 'graphite'
  depends_on 'cras'
  depends_on 'sommelier'

  def self.install
    # llvm-strip doesn't works with opera
    ENV['CREW_NOT_STRIP'] = '1'

    # since opera put the executable to library, we need to link it to CREW_PREFIX
    FileUtils.ln_sf "#{CREW_LIB_PREFIX}/opera/opera", 'bin/opera'

    # place all stuff to lib64 instead of lib
    FileUtils.mv 'lib/x86_64-linux-gnu/', 'share/'
    FileUtils.rm_rf 'lib/'

    FileUtils.mkdir_p CREW_DEST_PREFIX
    FileUtils.mv Dir.glob('*'), CREW_DEST_PREFIX
  end

  def self.postinstall
    puts
    puts 'Set Opera as your default browser? [Y/n]: '
    case STDIN.gets.chomp
    when "\n", 'Y', 'y', 'yes'
      Dir.chdir("#{CREW_PREFIX}/bin") do
        FileUtils.ln_sf "#{CREW_LIB_PREFIX}/opera/opera", 'x-www-browser'
      end
    else
      puts 'No change has been made.'
      puts
    end
  end

  def self.remove
    Dir.chdir("#{CREW_PREFIX}/bin") do
      FileUtils.rm 'x-www-browser' if File.symlink?('x-www-browser') && File.realpath('x-www-browser') == "#{CREW_LIB_PREFIX}/opera/opera"
    end
  end
end
