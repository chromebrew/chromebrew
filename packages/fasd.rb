require 'package'

class Fasd < Package
  description 'Command-line productivity booster, offers quick access to files and directories, inspired by autojump, z and v.'
  homepage 'https://github.com/clvv/fasd'
  version '1.0.1'
  source_url 'https://github.com/clvv/fasd/archive/1.0.1.tar.gz'
  source_sha256 '88efdfbbed8df408699a14fa6c567450bf86480f5ff3dde42d0b3e1dee731f65'

  def self.install
    system "sed -i 's,share/man,man,' Makefile"
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    puts ""
    puts "To get fasd working in a shell, some initialization code must be run:".lightblue
    puts "echo 'eval \"\$(fasd --init auto)\"' >> ~/.bashrc && source ~/.bashrc".lightblue
    puts ""
  end
end
