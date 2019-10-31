require 'package'

class Setuptools < Package
  description 'Easily download, build, install, upgrade, and uninstall Python packages'
  homepage 'https://pypi.org/project/setuptools/'
  version '41.6.0'
  source_url 'https://github.com/pypa/setuptools/archive/v41.6.0.tar.gz'
  source_sha256 '1b91aa309ffa43656774984557d62fae1fded0491a16ba8084b21c92cd5ad093'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/setuptools-41.6.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/setuptools-41.6.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/setuptools-41.6.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/setuptools-41.6.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '367299e31ea2f88d4f93d5f1cf2cf374d3bc971f67a5b9306376ff8fdb35589b',
     armv7l: '367299e31ea2f88d4f93d5f1cf2cf374d3bc971f67a5b9306376ff8fdb35589b',
       i686: '27b624776104aafcd5905616b23b7eaf09a144e617be164a36d410f0e2e99d03',
     x86_64: '0d8ab47acdfc8a951166b34ff696a1b62f630dc93146f8f8b3f6a79a466e0281',
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
