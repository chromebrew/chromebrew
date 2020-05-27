require 'package'

class Doom_emacs < Package
  description 'An extensible, customizable, free/libre text editor - and more.'
  homepage 'https://www.gnu.org/software/emacs/'
  version '27.0.91'
  source_url 'http://git.savannah.gnu.org/cgit/emacs.git/snapshot/emacs-27.0.91.tar.gz'
  source_sha256 'ac7b71927dfdfa3b9c034da82e827ee28e7467d58953dafed69e9ce9d700cebd'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'giflib'
  depends_on 'libjpeg'
  depends_on 'libpng'
  depends_on 'libtiff'
  depends_on 'cairo'
  depends_on 'libxaw'
  depends_on 'libxpm'
  depends_on 'wxwidgets'
  depends_on 'imagemagick6'
  depends_on 'sommelier'

  def self.build
    system './autogen.sh'
    system './configure',
            "--prefix=#{CREW_PREFIX}",
            "--localstatedir=#{CREW_PREFIX}/share",
            '--without-selinux',
            '--with-x=yes',
            '--with-x-toolkit=gtk',
            '--with-gif=yes',
            '--with-jpeg=yes',
            '--with-png=yes',
            '--with-rsvg=yes',
            '--with-xaw=yes',
            '--with-xpm=yes',
            '--with-tiff=yes',
            '--without-makeinfo',
            '--with-pdumper',
            '--with-gnutls',
            '--with-cairo'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    system 'install', '-Dm755', 'src/emacs', "#{CREW_DEST_PREFIX}/bin/gemacs"
    system 'install', '-Dm755', 'src/emacs-27.0.91.1', "#{CREW_DEST_PREFIX}/bin/gemacs-27.0.91"
    if Dir.exist?("#{HOME}/.emacs.d")
      puts "~/.emacs.d already exists. Delete it ? (y/n) ".orange
      while answer = STDIN.gets.chomp
        case answer
          when 'y'
            puts "Removing ~/.emacs.d...".orange
            FileUtils.remove_dir("#{HOME}/.emacs.d",true) 
            break
          when 'n'
            puts "Doom_emacs not installed. Please remove ~/.emacs.d".lightred
            abort
            break
          else
            puts "  Please select from one of the options."
        end
      end
    end
    system "git clone --depth 1 https://github.com/hlissner/doom-emacs #{HOME}/.emacs.d"
    system "#{HOME}/.emacs.d/bin/doom -y install"
  end

  def self.postinstall
    system "#{HOME}/.emacs.d/bin/doom sync"
    system "#{HOME}/.emacs.d/bin/doom update"
    puts
    puts "To complete the installation, execute the following:".lightblue
    puts "echo 'export PATH=$PATH:$HOME/.emacs.d/bin' >> ~/.bashrc".lightblue
    puts "source ~/.bashrc".lightblue
    puts
    puts "Available Commands :"
    puts " - " + "'doom sync'".blue + " to synchronize your private config with Doom by installing missing packages, removing orphaned packages, and regenerating caches. Run this whenever you modify your private init.el or packages.el, or install/remove an Emacs package through your OS package manager (e.g. mu4e or agda).".lightblue
    puts " - " + "'doom upgrade'".blue + " to update Doom to the latest release & all installed packages.".lightblue
    puts " - " + "'doom update'".blue + " to update all installed packages to the latest release.".lightblue
    puts " - " + "'doom doctor'".blue + " to diagnose common issues with your system and config.".lightblue
    puts " - " + "'doom env'".blue + " to dump a snapshot of your shell environment to a file that Doom will load at startup. This allows Emacs to inherit your PATH, among other things.".lightblue
    puts " - " + "'doom build'".blue + " to recompile all installed packages (use this if you up/downgrade Emacs).".lightblue
    puts
  end

end
