require 'package'

class Brackets < Package
  description 'A modern, open source text editor that understands web design.'
  homepage 'http://brackets.io/'
  version '1.14.1-1'
  case ARCH
  when 'i686', 'x86_64'
    source_url 'https://github.com/adobe/brackets/archive/release-1.14.1.tar.gz'
    source_sha256 '9a07fc80a155d2490be4eff77a2622539012325cef18e89305b8bc45c4c3833d'
    depends_on 'alien' => :build
    depends_on 'gtk2'
    depends_on 'libgconf'
    depends_on 'xdg_base'
    depends_on 'sommelier'
  end

  binary_url ({
      i686: 'https://dl.bintray.com/chromebrew/chromebrew/brackets-1.14.1-chromeos-i686.tar.xz',
    x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/brackets-1.14.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
      i686: '815c23b388b937fbfeb8bb109297c597dcebe3b031ad3e1a718463f5a38cb67e',
    x86_64: 'ddcef49b895b1d132ceef90406044ce7699cc21dfa1d048e059bafa2945399bc',
  })

  def self.build
    case ARCH
    when 'x86_64'
      arch = '64-bit'
      sha256 = 'dd8346ee7061e8820ecb7859f5cdccb6f199b144dd17192c217dd49512c4452b'
    when 'i686'
      arch = '32-bit'
      sha256 = '6ef1567b75a197236b3d35785afa744752a28b74cfa51b93b7b78d0a50acbfd4'
    end
    package = "Brackets.Release.#{version}.#{arch}.deb"
    system "wget https://github.com/adobe/brackets/releases/download/release-#{version}/#{package}"
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read(package) ) == sha256
    system "alien -tc #{package}"
    system "tar xvf brackets-#{version}.tgz"
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_HOME}/.config/Brackets"
    FileUtils.mv 'usr/share', "#{CREW_DEST_PREFIX}"
    FileUtils.mv 'opt/brackets', "#{CREW_DEST_PREFIX}/share"
    FileUtils.ln_s "#{CREW_PREFIX}/share/brackets/Brackets", "#{CREW_DEST_PREFIX}/bin/brackets"
    system "touch #{CREW_DEST_HOME}/.config/Brackets/window.ini"
  end
end
