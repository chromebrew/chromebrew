require 'package'

class Six < Package
  description 'Six is a Python 2 and 3 compatibility library.'
  homepage 'https://github.com/benjaminp/six'
  version '1.14.0'
  source_url 'https://github.com/benjaminp/six/archive/1.14.0.tar.gz'
  source_sha256 '6efff7289d1d369f0a25180433aba83ec2584e489e90f115b52ba69e4816cfb4'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/six-1.14.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/six-1.14.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/six-1.14.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/six-1.14.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '194646b4fb1a0ed11492d21a45bc09d91ab7da78cbc8a6ad2f0c3ebe723692ba',
     armv7l: '194646b4fb1a0ed11492d21a45bc09d91ab7da78cbc8a6ad2f0c3ebe723692ba',
       i686: '51c17725b9925874af0fa7bcd86afbc930b5023ab353efb3754c69d7e7d52d4c',
     x86_64: '649ca8a551af2fd558bc889cfa0df05ff2e2b853ea76786b61d5d8a765adcd02',
  })

  depends_on 'python3'
  depends_on 'python27'

  def self.build
    system "python2.7 setup.py build"
    system "python3 setup.py build"
  end

  def self.install
    system "python2.7 setup.py install --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR}"
    system "python3 setup.py install --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR}"
  end
end
