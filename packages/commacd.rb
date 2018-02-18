require 'package'

class Commacd < Package
  description 'A faster way to move around (Bash 3+)'
  homepage 'https://github.com/shyiko/commacd'
  version '0.3.4'
  source_url 'https://github.com/shyiko/commacd/archive/v0.3.4.tar.gz'
  source_sha256 'e27401c5455eb0b89f8e5a3c1e69165d3b73c90a4cb37f439ed27bf120411de0'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/commacd-0.3.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/commacd-0.3.4-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/commacd-0.3.4-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/commacd-0.3.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'bb80d9e7c3582ac072e8fb1bcac6776965eb47de2436a0b66179e42ba6a41aa5',
     armv7l: 'bb80d9e7c3582ac072e8fb1bcac6776965eb47de2436a0b66179e42ba6a41aa5',
       i686: 'ea9b6580c9ab76779aba693fbbc2b7558e55699c7084ba9d2e20357bf343d688',
     x86_64: '9eb55570e99619a29c92f177074f685f9ecc92c5511d41f3c96c0640bd51154d',
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
