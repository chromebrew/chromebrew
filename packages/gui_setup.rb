require 'package'

class Gui_setup < Package
  description 'Graphical environment setup for Chromebrew GUI applications'
  homepage 'https://github.com/skycocker/chromebrew/'
  version '1.0'
  license 'GPL-3+'
  compatibility 'all'

  is_fake

  def self.preflight
    # exo wayland compositor is required for sommelier
    abort 'Graphical environment is not supported in your Chrome OS version'.lightred \
      unless ( begin; File.stat('/var/run/chrome/wayland-').socket?; rescue Errno::ENOENT; false; end )

    puts <<~EOT
      Select display server:

      1 = exo: Chrome OS built-in Wayland compositor (Wayland)
      2 = sommelier: Nested Wayland compositor with X11 and acceleration support (Recommended) (Wayland & X11)
      0 = Cancel

    EOT

    while @ver = STDIN.gets.chomp
      case @ver
      when '0'
        abort
      when '1'
        depends_on 'exo_base'
        break
      when '2'
        depends_on 'sommelier'
        break
      else
        puts "\nPlease select from one of the options or enter 0 to cancel.".yellow
      end
    end
  end
end
