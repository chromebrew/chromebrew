require 'package'

class Urlwatch < Package
  description 'A tool for monitoring webpages for updates'
  homepage 'https://thp.io/2008/urlwatch/'
  version '2.7'
  source_url 'https://github.com/thp/urlwatch/archive/2.7.tar.gz'
  source_sha256 '0a7b46d161501463dda99a1d82daf00237e2627616beaa6ccbf04d6c70c68ded'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/urlwatch-2.7-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/urlwatch-2.7-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/urlwatch-2.7-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/urlwatch-2.7-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '5ecc98aa4e7b3bd272e8d6f6d3a7853ba13fcb3b52860ff01db57ec5d918006c',
     armv7l: '5ecc98aa4e7b3bd272e8d6f6d3a7853ba13fcb3b52860ff01db57ec5d918006c',
       i686: '837f7d929fac45f0646c3234352477a7d39be36a2e4572c4dd32280653106a6f',
     x86_64: '30ee35e2482bdd829615eb43cb785b52aa910ce2b45ad941366d85693bbc8839',
  })

  depends_on 'python3'
  depends_on 'filecmd'

  def self.install
    majorver=`python3 -V | xargs | cut -d' ' -f2 | cut -d'.' -f1`.chomp
    minorver=`python3 -V | xargs | cut -d' ' -f2 | cut -d'.' -f2`.chomp
    pythonver="#{majorver}.#{minorver}"
    system "python3 -m pip install pyyaml minidb requests keyring appdirs chump pushbullet.py pycodestyle"
    system "pip3 install urlwatch"
    system "install -Dm755 #{CREW_PREFIX}/bin/keyring #{CREW_DEST_PREFIX}/bin/keyring"
    system "install -Dm755 #{CREW_PREFIX}/bin/pycodestyle #{CREW_DEST_PREFIX}/bin/pycodestyle"
    system "install -Dm755 #{CREW_PREFIX}/bin/urlwatch #{CREW_DEST_PREFIX}/bin/urlwatch"
    system "mkdir -p #{CREW_DEST_PREFIX}/lib/python#{pythonver}/site-packages/__pycache__"
    system "cp #{CREW_PREFIX}/lib/python#{pythonver}/site-packages/__pycache__/minidb* #{CREW_DEST_PREFIX}/lib/python#{pythonver}/site-packages/__pycache__"
    system "cp #{CREW_PREFIX}/lib/python#{pythonver}/site-packages/__pycache__/appdirs* #{CREW_DEST_PREFIX}/lib/python#{pythonver}/site-packages/__pycache__"
    system "cp #{CREW_PREFIX}/lib/python#{pythonver}/site-packages/__pycache__/pycodestyle* #{CREW_DEST_PREFIX}/lib/python#{pythonver}/site-packages/__pycache__"
    system "cp -r #{CREW_PREFIX}/lib/python#{pythonver}/site-packages/PyYAML* #{CREW_DEST_PREFIX}/lib/python#{pythonver}/site-packages"
    system "cp -r #{CREW_PREFIX}/lib/python#{pythonver}/site-packages/yaml* #{CREW_DEST_PREFIX}/lib/python#{pythonver}/site-packages"
    system "cp -r #{CREW_PREFIX}/lib/python#{pythonver}/site-packages/minidb* #{CREW_DEST_PREFIX}/lib/python#{pythonver}/site-packages"
    system "cp -r #{CREW_PREFIX}/lib/python#{pythonver}/site-packages/requests* #{CREW_DEST_PREFIX}/lib/python#{pythonver}/site-packages"
    system "cp -r #{CREW_PREFIX}/lib/python#{pythonver}/site-packages/keyring* #{CREW_DEST_PREFIX}/lib/python#{pythonver}/site-packages"
    system "cp -r #{CREW_PREFIX}/lib/python#{pythonver}/site-packages/appdirs* #{CREW_DEST_PREFIX}/lib/python#{pythonver}/site-packages"
    system "cp -r #{CREW_PREFIX}/lib/python#{pythonver}/site-packages/chump* #{CREW_DEST_PREFIX}/lib/python#{pythonver}/site-packages"
    system "cp -r #{CREW_PREFIX}/lib/python#{pythonver}/site-packages/pushbullet* #{CREW_DEST_PREFIX}/lib/python#{pythonver}/site-packages"
    system "cp -r #{CREW_PREFIX}/lib/python#{pythonver}/site-packages/pycodestyle* #{CREW_DEST_PREFIX}/lib/python#{pythonver}/site-packages"
    system "cp -r #{CREW_PREFIX}/lib/python#{pythonver}/site-packages/urlwatch* #{CREW_DEST_PREFIX}/lib/python#{pythonver}/site-packages"
    system "gzip -9 #{CREW_PREFIX}/share/man/man1/urlwatch.1"
    system "install -Dm644 #{CREW_PREFIX}/share/man/man1/urlwatch.1.gz #{CREW_DEST_PREFIX}/share/man/man1/urlwatch.1.gz"
    system "mkdir -p #{CREW_DEST_PREFIX}/share/urlwatch"
    system "cp -r #{CREW_PREFIX}/share/urlwatch #{CREW_DEST_PREFIX}/share"
  end
end
