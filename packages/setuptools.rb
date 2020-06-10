require 'package'

class Setuptools < Package
  description 'Easily download, build, install, upgrade, and uninstall Python packages'
  homepage 'https://pypi.org/project/setuptools/'
  version '46.1.3'
  compatibility 'all'
  source_url 'https://github.com/pypa/setuptools/archive/v46.1.3.tar.gz'
  source_sha256 '984eeb7909fa610a441711c00dc4fa5bbf3c49f9b4b5204b56b7362bdd04f397'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/setuptools-46.1.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/setuptools-46.1.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/setuptools-46.1.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/setuptools-46.1.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '480fa13c1f2ef97d31e08ec9da385f71034a878ec6a19ccfa7ef4fc776a12142',
     armv7l: '480fa13c1f2ef97d31e08ec9da385f71034a878ec6a19ccfa7ef4fc776a12142',
       i686: '758a37bddd867c069f237a6d70e56377e088391f1a75e1d81a230838aa5cd242',
     x86_64: '58f237baeb6e5de572d63a357d8b5c92288112db572f619bb40713319692a94c',
  })

  depends_on 'python27'
  depends_on 'python3'

  def self.build
    system 'python3 bootstrap.py'
  end

  def self.install
    system "python2 setup.py install --root #{CREW_DEST_DIR} --prefix #{CREW_PREFIX}"
    system "python3 setup.py install --root #{CREW_DEST_DIR} --prefix #{CREW_PREFIX}"
  end
end
