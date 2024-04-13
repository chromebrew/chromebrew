require 'package'

class Wing < Package
  description 'Wing Personal is a free Python IDE designed for students and hobbyists.'
  homepage 'https://wingware.com/'
  version '10.0.3.0'
  license 'Wingware-EULA'
  compatibility 'x86_64'
  source_url 'https://wingware.com/pub/wing-personal/10.0.3.0/wing-personal-10.0.3.0-linux-x64.tar.bz2'
  source_sha256 '162c28ce5f5142da380155b03a0409d085e9706b0c22a6376e9e189cd8ef6b4b'

  depends_on 'xcb_util_cursor'
  depends_on 'xcb_util_keysyms'
  depends_on 'xcb_util_wm'
  depends_on 'sommelier'

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/wing-personal"
    FileUtils.mkdir_p "#{CREW_DEST_HOME}/.wingpersonal10"
    FileUtils.touch "#{CREW_DEST_HOME}/.wingpersonal10/ide.log"
    system 'tar xvf binary-package-10.0.3.0.tar'
    FileUtils.rm %w[binary-package-10.0.3.0.tar wing-install.py]
    FileUtils.mv Dir['*'], "#{CREW_DEST_PREFIX}/share/wing-personal"
    FileUtils.ln_s "#{CREW_PREFIX}/share/wing-personal/wing-personal", "#{CREW_DEST_PREFIX}/bin/wing"
  end

  def self.postinstall
    ExitMessage.add "\nType 'wing' to get started.\n".lightblue
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
