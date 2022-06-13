require 'package'

class Cheat < Package
  description 'Create and view interactive cheatsheets on the command-line.'
  homepage 'https://github.com/cheat/cheat'
  version '4.2.3'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'xdg_base'

  def self.install
    case ARCH
    when 'aarch64', 'armv7l'
      url = 'https://github.com/cheat/cheat/releases/download/4.2.3/cheat-linux-arm7.gz'
      sha256 = '4ac2fea19ff1dd063f7fa7e76b5329babeaee8c10756eeeffa8fafecd8c8dabc'
    when 'i686'
      url = 'https://github.com/cheat/cheat/releases/download/4.2.3/cheat-linux-386.gz'
      sha256 = 'faca842f1b5b200558f899c2730cadec00a261cdabbb9fad8638f2487bed8059'
    when 'x86_64'
      url = 'https://github.com/cheat/cheat/releases/download/4.2.3/cheat-linux-amd64.gz'
      sha256 = '899e7d88d9441b9a32034b0c4b6761157e7977131932a2abc13a382794e7ea6c'
    end
    downloader url, sha256, 'cheat.gz'
    Zlib::GzipReader.open('cheat.gz') { |gz| File.write('cheat', gz.read) }
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.install 'cheat', "#{CREW_DEST_PREFIX}/bin/cheat", mode: 0o755
  end

  def self.remove
    config_dir = "#{HOME}/.config/cheat"
    if Dir.exist? config_dir
      puts "WARNING: This will remove all cheat config!".orange
      print "Would you like to remove the #{config_dir} directory? [y/N] "
      case STDIN.getc
      when 'y', 'Y'
        FileUtils.rm_rf config_dir
        puts "#{config_dir} removed.".lightgreen
      else
        puts "#{config_dir} saved.".lightgreen
      end
    end
  end
end
