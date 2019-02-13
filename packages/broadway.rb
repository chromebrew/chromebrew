require 'package'

class Broadway < Package
  description 'Run GTK applications in a browser window.'
  homepage 'https://developer.gnome.org/gtk3/stable/gtk-broadway.html'
  version 'gtk3.22-3'
  source_url 'file:///dev/null'
  source_sha256 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'gtk3'
  
  def self.postinstall
    puts 'To configure the Broadway daemon, remove the former'.lightblue
    puts ' "Broadway environment variables + daemon" section'.lightblue
    puts ' from `~/.bashrc`, and run this:'.lightblue
    puts
    puts 'echo "# Broadway configuration" >> ~/.bashrc'.lightblue
    puts 'echo "DISPLAY=:5" >> ~/.bashrc'.lightblue
    puts 'echo "GDK_BACKEND=broadway" >> ~/.bashrc'.lightblue
    puts "echo 'alias broadwaydd=\"broadwayd \\\${DISPLAY} &>/dev/null &\"' >> ~/.bashrc".lightblue
    puts
    puts 'If you want to use Broadway as your default graphical display, run this:'.lightblue
    puts
    puts 'echo "export DISPLAY" >> ~/.bashrc'.lightblue
    puts 'echo "export GDK_BACKEND" >> ~/.bashrc'.lightblue
    puts
    puts 'If you would like to run Broadway on startup, run the above commands and then run this:'.lightblue
    puts
    puts 'echo "broadwaydd" >> ~/.bashrc'.lightblue
    puts
  end
end
