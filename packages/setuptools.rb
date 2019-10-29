require 'package'

class Setuptools < Package
  description 'Easily download, build, install, upgrade, and uninstall Python packages'
  homepage 'https://pypi.org/project/setuptools/'
  version '41.6.0'
  source_url 'https://github.com/pypa/setuptools/archive/v41.6.0.tar.gz'
  source_sha256 '1b91aa309ffa43656774984557d62fae1fded0491a16ba8084b21c92cd5ad093'

  binary_url ({
  })
  binary_sha256 ({
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
