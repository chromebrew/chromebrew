require 'package'

class Code < Package
  description 'Visual Studio Code is a source code editor developed by Microsoft for Windows, Linux and macOS.'
  homepage 'https://code.visualstudio.com/docs/?dv=linux64'
  version '1.25'
  case ARCH
  when "x86_64"
    source_url 'https://go.microsoft.com/fwlink/?LinkID=620884'
    source_sha256 '5856bbebf38aa05d584da4722869bbe507cf123f69f7ffab5f1532d73dbf3438'
  when "i686"
    source_url 'https://go.microsoft.com/fwlink/?LinkID=620885'
    source_sha256 'af6adc2e2500e50bfebe7ee7b97d661b6e774a590136bf5f89334132a5b292e2'
  else
    source_url 'https://raw.githubusercontent.com/Microsoft/vscode/1.25.1/README.md'
    source_sha256 'c1c5e6ec903730a4e116c1cfd83bb29acd227195d97f2ec8944452808232c310'
  end

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'sommelier'
  depends_on 'xterm'
  depends_on 'libgconf'
  depends_on 'xdg_base'

  def self.install
    case ARCH
    when 'armv7l', 'aarch64'
      puts
      puts 'Visual Studio Code is currently not supported on ARM and AArch64.'.lightred
      puts 'Please try HeadMelted.'.lightred
      puts 'https://code.headmelted.com'.lihghtred
      puts
      puts 'Happy coding!'.lightgreen
      puts
      return 1
    else
      system "mkdir", "-p", "#{CREW_DEST_PREFIX}/lib/code"
      system "mkdir", "-p", "#{CREW_DEST_PREFIX}/bin"
      system "cp", "-rpa", ".", "#{CREW_DEST_PREFIX}/lib/code/"
      system "echo '#!/bin/bash' > #{CREW_DEST_PREFIX}/bin/code"
      system "echo >> #{CREW_DEST_PREFIX}/bin/code"
      system "echo 'xterm -e #{CREW_PREFIX}/lib/code/bin/code' >> #{CREW_DEST_PREFIX}/bin/code"
      system "chmod a+x #{CREW_DEST_PREFIX}/bin/code"
    end
  end
end
