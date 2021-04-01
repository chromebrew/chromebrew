require 'package'

class Exo_base < Package
  description 'Environment set-up for Chrome OS built-in Wayland server'
  homepage 'https://github.com/skycocker/chromebrew/'
  version '1.0'
  license 'GPL-3+'
  compatibility 'all'
  source_url 'file:///dev/null'
  source_sha256 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855'

  def self.preflight
    abort 'Wayland is not supported in your Chrome OS version'.lightred unless File.stat('/var/run/chrome/wayland-0').socket?
  end

  def self.build
    @env = <<~EOF
      # environment set-up for Chrome OS built-in Wayland server
      set -a
      # all variables will export automatically

      XDG_RUNTIME_DIR=/var/run/chrome
      XDG_SESSION_TYPE=wayland
      WAYLAND_DISPLAY=wayland-0

      CLUTTER_BACKEND=wayland
      GDK_BACKEND=wayland

      set +a
    EOF
  end

  def self.install
    system "echo '#{@env}' >> #{HOME}/.bashrc" unless `grep -c '#{@env.lines.first.chomp}' #{HOME}/.bashrc`.to_i > 0
    FileUtils.mkdir_p("#{CREW_DEST_PREFIX}/etc/env.d/")
    #File.write("#{CREW_DEST_PREFIX}/etc/env.d/exo_base", @env)
  end

  def self.postinstall
    puts <<~EOT.lightblue

      To complete the installation, execute the following:
      
      source #{HOME}/.bashrc

    EOT
  end
end
