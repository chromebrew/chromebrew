require 'package'

class Duplicity < Package
  description 'Duplicity backs directories by producing encrypted tar-format volumes and uploading them to a remote or local file server.'
  homepage 'http://duplicity.nongnu.org/'
  version '0.7.15-1'
  compatibility 'all'
  license 'GPL-3'
  source_url 'https://code.launchpad.net/duplicity/0.7-series/0.7.15/+download/duplicity-0.7.15.tar.gz'
  source_sha256 '50bf7d14413284ecb036146ab9ba0e271937f2fa7826f8c8300b2965eb450a6c'

  depends_on 'python27'
  depends_on 'librsync'
  depends_on 'gnupg'
  depends_on 'openssh'
  depends_on 'py2_setuptools' => :build

  def self.build
    system "python2 setup.py build #{CREW_SETUP_PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python2 setup.py install #{CREW_SETUP_PY_INSTALL_OPTIONS}"
  end
end
