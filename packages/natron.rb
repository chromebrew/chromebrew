require 'package'

class Natron < Package
  description 'Open Source Compositing Software For VFX and Motion Graphics.'
  homepage 'https://natrongithub.github.io/'
  version '2.4.0'
  license 'GPL-2'
  compatibility 'x86_64'
  source_url 'https://github.com/NatronGitHub/Natron/releases/download/v2.4.0/Natron-2.4.0-Linux-64.tgz'
  source_sha256 '7e8f2ec343f553799f34dce89aa250c410024f17e2c9ccfb5e22544db3e46bb4'
  binary_compression 'tpxz'

  no_compile_needed

  binary_sha256({
    x86_64: '35b3c22b67f74d285e71f619179cf36a3a475d0df37dd7dcb104d22a318edce4'
  })

  depends_on 'desktop_file_utils'
  depends_on 'libglu'
  depends_on 'sommelier'

  def self.install
    # IMPORTANT BUILD/INSTALL FROM SOURCE INSTRUCTIONS BELOW:
    # Enter /usr/local/tmp/crew/dest/usr/local/share/Natron-#{version} for the install directory.
    # Uncheck 'Run Natron now' at the end of the install wizard.
    system "./Natron-#{version}-Linux-64"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.ln_s "#{CREW_PREFIX}/share/Natron-#{version}/Natron", "#{CREW_DEST_PREFIX}/bin/natron"
  end

  def self.postinstall
    puts "\nType 'natron' to get started.\n".lightblue
  end

  def self.remove
    config_dir = "#{HOME}/.Natron"
    if Dir.exist? config_dir
      print "Would you like to remove the config directory #{config_dir}? [y/N] "
      case $stdin.gets.chomp.downcase
      when 'y', 'yes'
        FileUtils.rm_rf config_dir
        puts "#{config_dir} removed.".lightred
      else
        puts "#{config_dir} saved.".lightgreen
      end
    end
  end
end
