require 'package'

class Code < Package
  description 'Visual Studio Code is a source code editor developed by Microsoft for Windows, Linux and macOS.'
  homepage 'https://code.visualstudio.com/'
  version '1.25'
  case ARCH
  when 'x86_64'
    # code-stable-1534444642.tar.gz
    source_url 'https://go.microsoft.com/fwlink/?LinkID=620884'
    source_sha256 '5ef2f82e1272b0008a446fc8f62f9693e2af7c83d5922883ecbfd8a9986fd40b'
  when 'i686'
    # code-stable-1534444635.tar.gz 
    source_url 'https://go.microsoft.com/fwlink/?LinkID=620885'
    source_sha256 '16a9eb4582767c31ca92fce9d7ed97b960175d8a97db25fab3c8e56afec2f3bc'
  else
    source_url 'https://raw.githubusercontent.com/Microsoft/vscode/1.25.1/README.md'
    source_sha256 'c1c5e6ec903730a4e116c1cfd83bb29acd227195d97f2ec8944452808232c310'
  end

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'gtk2'
  depends_on 'libgconf'
  depends_on 'xdg_base'
  depends_on 'sommelier'

  def self.install
    case ARCH
    when 'x86_64', 'i686'
      system "mkdir", "-p", "#{CREW_DEST_PREFIX}/share/code"
      system "mkdir", "-p", "#{CREW_DEST_PREFIX}/bin"
      system "cp", "-rpa", ".", "#{CREW_DEST_PREFIX}/share/code/"
      system "ln", "-s", "#{CREW_PREFIX}/share/code/bin/code", "#{CREW_DEST_PREFIX}/bin"
    else
      puts
      puts 'Visual Studio Code is currently not supported on ARM and AArch64.'.lightred
      puts 'Please try HeadMelted.'.lightred
      puts 'https://code.headmelted.com'.lightred
      puts
      puts 'Happy coding!'.lightgreen
      puts
      exit 1
    end
  end

  def self.postinstall
    puts
    puts 'Congratulations! You have installed Visual Studio Code on Chrome OS!'.lightgreen
    puts 'Now, please run \'code\' to start Visual Studio.'.lightgreen
    puts 'Happy coding!'.lightgreen
    puts
  end
end
