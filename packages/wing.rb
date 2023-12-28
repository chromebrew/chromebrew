require 'package'

class Wing < Package
  description 'Wing Personal is a free Python IDE designed for students and hobbyists.'
  homepage 'https://wingware.com/'
  version '10.0.0.1'
  license 'Wingware-EULA'
  compatibility 'x86_64'
  source_url 'https://wingware.com/pub/wing-personal/10.0.0.1/wing-personal-10.0.0.1-linux-x64.tar.bz2'
  source_sha256 '45e01632ebe36047e6407f48abcfe7a3922b2ff694611a150458f4d23f821e5d'

  depends_on 'xcb_util_cursor'
  depends_on 'xcb_util_keysyms'
  depends_on 'xcb_util_wm'
  depends_on 'sommelier'

  no_compile_needed

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/wing-personal"
    FileUtils.mkdir_p "#{CREW_DEST_HOME}/.wingpersonal10"
    FileUtils.touch "#{CREW_DEST_HOME}/.wingpersonal10/ide.log"
    system 'tar xvf binary-package-10.0.0.b1.tar'
    FileUtils.rm %w[binary-package-10.0.0.b1.tar wing-install.py]
    FileUtils.mv Dir['*'], "#{CREW_DEST_PREFIX}/share/wing-personal"
    FileUtils.ln_s "#{CREW_PREFIX}/share/wing-personal/wing-personal", "#{CREW_DEST_PREFIX}/bin/wing"
  end

  def self.postinstall
    puts "\nType 'wing' to get started.\n".lightblue
  end

  def self.remove
    config_dir = "#{HOME}/.wingpersonal10"
    if Dir.exist? config_dir
      print "Would you like to remove the #{config_dir} directory? [y/N] "
      case $stdin.gets.chomp.downcase
      when 'y', 'yes'
        FileUtils.rm_rf config_dir
        puts "#{config_dir} removed.".lightgreen
      else
        puts "#{config_dir} saved.".lightgreen
      end
    end
  end
end
