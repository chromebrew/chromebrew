require 'package'

class Vivaldi < Package
  description 'Vivaldi is a new browser that blocks unwanted ads, protects you from trackers, and puts you in control with unique built-in features.'
  homepage 'https://vivaldi.com/'
  version '3.4.2066.76'
  compatibility 'aarch64,armv7l,x86_64'
  source_url 'file:///dev/null'
  source_sha256 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/vivaldi-3.4.2066.76-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/vivaldi-3.4.2066.76-chromeos-armv7l.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/vivaldi-3.4.2066.76-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '3e7ae1d2390328fed4fa6fbef334bc986bba013b567e8ed4e4176c4dda22568b',
     armv7l: '3e7ae1d2390328fed4fa6fbef334bc986bba013b567e8ed4e4176c4dda22568b',
     x86_64: 'ddcc649cc4580e12c28769f5b4ecb6a647841a902fc6a557ef27613eb02a4f60',
  })

  case ARCH
  when 'aarch64', 'armv7l', 'x86_64'
    depends_on 'alien' => :build
    depends_on 'cras'
    depends_on 'gtk3'
    depends_on 'gsettings_desktop_schemas'
    depends_on 'libx264'
    depends_on 'xdg_base'
    depends_on 'xdg_utils'
    depends_on 'sommelier'
  end

  def self.build
    case ARCH
    when 'aarch64', 'armv7l'
      arch = 'armhf'
      sha256 = '3288843c31b86edcdc4f1a6ba33832d926244e60e14157e602ae7420bb860adc'
    when 'x86_64'
      arch = 'amd64'
      sha256 = 'f9d457943b40e2bd4edd6d7d6cf069bd9cb690b5da60f7ec314837840194abfa'
    end
    system "wget https://downloads.vivaldi.com/stable/vivaldi-stable_#{version}-1_#{arch}.deb"
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read("vivaldi-stable_#{version}-1_#{arch}.deb") ) == sha256
    system "alien -tc vivaldi-stable_#{version}-1_#{arch}.deb"
    system "tar xvf vivaldi-stable-#{version}.tgz"
  end

  def self.install
    FileUtils.mkdir_p CREW_DEST_PREFIX
    FileUtils.rm 'usr/bin/vivaldi-stable'
    FileUtils.mv 'usr/bin', CREW_DEST_PREFIX
    FileUtils.mv 'opt', CREW_DEST_PREFIX
    FileUtils.mv 'usr/share', CREW_DEST_PREFIX
    FileUtils.ln_s "#{CREW_PREFIX}/opt/vivaldi/vivaldi", "#{CREW_DEST_PREFIX}/bin/vivaldi"
  end

  def self.postinstall
    puts
    puts "Type 'vivaldi' to get started.".lightblue
    puts
    puts "To completely remove, execute the following:".lightblue
    puts "crew remove vivaldi".lightblue
    puts "rm -rf ~/.config/vivaldi".lightblue
    puts "rm -rf ~/.config/lib/vivaldi".lightblue
    puts "rm -f ~/.config/share/.vivaldi_reporting_data".lightblue
    puts
  end
end
