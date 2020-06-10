require 'package'

class Commacd < Package
  description 'A faster way to move around (Bash 3+)'
  homepage 'https://github.com/shyiko/commacd'
  version '0.4.0'
  compatibility 'all'
  source_url 'https://github.com/shyiko/commacd/archive/v0.4.0.tar.gz'
  source_sha256 'e2db36c6c8dcd4e65cd8d2d90101d5b7aee78872ae29d2d47ab7fc3b263897cd'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/commacd-0.4.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/commacd-0.4.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/commacd-0.4.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/commacd-0.4.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '2c4ee0774eb845fc807861bfd9cb08637a1b75b14b7b7c9e9b9c9b9a906b1de4',
     armv7l: '2c4ee0774eb845fc807861bfd9cb08637a1b75b14b7b7c9e9b9c9b9a906b1de4',
       i686: 'cd3d5341bc1bf38ec7a9080c815a948aac3e662a86e76854cf502aa2bde55b7b',
     x86_64: '33610884cc935710e12a5b3c7fff1b918549c3dc3fd1b61f604adca6ac751dd8',
  })

  def self.install
    system "install -Dm644 commacd.bash #{CREW_DEST_PREFIX}/share/commacd/commacd.bash"
  end

  def self.postinstall
    puts
    puts "To complete installation, execute the following:".lightblue
    puts "echo '# commacd completion' >> ~/.bashrc".lightblue
    puts "echo 'if [ -f #{CREW_PREFIX}/share/commacd/commacd.bash ]; then' >> ~/.bashrc".lightblue
    puts "echo '  source #{CREW_PREFIX}/share/commacd/commacd.bash' >> ~/.bashrc".lightblue
    puts "echo 'fi' >> ~/.bashrc".lightblue
    puts "source ~/.bashrc".lightblue
    puts
  end
end
