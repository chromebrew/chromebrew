require 'package'

class Urlwatch < Package
  description 'A tool for monitoring webpages for updates'
  homepage 'https://thp.io/2008/urlwatch/'
  version '2.7'
  source_url 'https://github.com/thp/urlwatch/archive/2.7.tar.gz'
  source_sha256 '0a7b46d161501463dda99a1d82daf00237e2627616beaa6ccbf04d6c70c68ded'

  binary_url ({
  })
  binary_sha256 ({
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
