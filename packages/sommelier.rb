require 'package'

class Sommelier < Package
  description 'Sommelier works by redirecting X11 and Wayland programs to the built-in ChromeOS wayland server.'
  homepage 'https://chromium.googlesource.com/chromiumos/containers/sommelier'
  version '1382ce084cc40'
  source_url 'https://chromium.googlesource.com/chromiumos/containers/sommelier/+/0.20/README?format=TEXT'
  source_sha256 'b58d799b16d20abf92369fe0749c73f7398996f0afa9933517051778a8bb16c3'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'mesa'
  depends_on 'xkbcomp'
  depends_on 'xsetroot'
  depends_on 'xorg_server'

  def self.build
    system 'git', 'clone', 'https://chromium.googlesource.com/chromiumos/containers/sommelier'
    Dir.chdir ('sommelier') do
      system 'git', 'reset', '--hard', version
      system 'sed', '-i', "s,/lib/,/#{ARCH_LIB}/,g", 'Makefile'
      system 'sed', '-i', "s,-I.,& -I#{CREW_PREFIX}/include/pixman-1,g", 'Makefile'
      system 'make', "PREFIX=#{CREW_PREFIX}", "SYSCONFDIR=#{CREW_PREFIX}/etc"
    end
  end

  def self.install
    Dir.chdir ('sommelier') do
      system 'make', "PREFIX=#{CREW_PREFIX}", "SYSCONFDIR=#{CREW_PREFIX}/etc", "DESTDIR=#{CREW_DEST_DIR}", 'install'
    end
  end

  def self.postinstall
    puts 'To configure the Sommelier daemon, remove the former'.lightblue
    puts ' "Sommelier environment variables + daemon" section'.lightblue
    puts ' from `~/.bashrc`, and run this:'.lightblue
    puts
    puts 'echo "# Sommelier configuration" >> ~/.bashrc'.lightblue
    puts 'echo "X_SCALE=1.5" >> ~/.bashrc'.lightblue
    puts 'echo "DISPLAY=:0" >> ~/.bashrc'.lightblue
    puts 'echo "GDK_BACKEND=wayland" >> ~/.bashrc'.lightblue
    puts 'echo "CLUTTER_BACKEND=wayland" >> ~/.bashrc'.lightblue
    puts 'echo "WAYLAND_DISPLAY=wayland-0" >> ~/.bashrc'.lightblue
    puts "echo 'alias sommelierd=\"sommelier -X --x-display=\\\${DISPLAY} --scale=${SCALE} --no-exit-with-child #{CREW_PREFIX}/etc/sommelierrc &>/dev/null &\"' >> ~/.bashrc".lightblue
    puts
    puts 'If you want to use Sommelier as your default graphical display, run this (also not recommended for `code`):'.lightblue
    puts
    puts 'echo "export DISPLAY" >> ~/.bashrc'.lightblue
    puts 'echo "export GDK_BACKEND" >> ~/.bashrc'
    puts 'echo "export CLUTTER_BACKEND" >> ~/.bashrc'
    puts 'echo "export WAYLAND_DISPLAY" >> ~/.bashrc'
    puts
    puts 'If you would like to run Sommelier on startup (not recommended for `code`), run the above commands and then run this:'.lightblue
    puts
    puts 'echo "sommelierd" >> ~/.bashrc'.lightblue
    puts
    puts 'If you are having issues with your installation,'.lightblue
    puts ' remove the `Sommelier configuration` section from `~/.bashrc`'.lightblue
    puts ' and try removing and reinstalling Sommelier from source, like this:'.lightblue
    puts
    puts 'crew remove sommelier && crew install -s sommelier'
    puts
  end
end
