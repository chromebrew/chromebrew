require 'package'

class Py2_setuptools < Package
  description 'Setuptools is the python build system from the Python Packaging Authority.'
  homepage 'https://setuptools.readthedocs.io/'
  # Newest python2 supported version as of 2021-04-24
  version '44.1.1'
  license 'MIT'
  compatibility 'all'
  source_url "https://files.pythonhosted.org/packages/b2/40/4e00501c204b457f10fe410da0c97537214b2265247bc9a5bc6edd55b9e4/setuptools-#{version}.zip"
  source_sha256 'c67aa55db532a0dadc4d2e20ba9961cbd3ccc84d544e9029699822542b5a476b'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: '668bdf06acc1e02d9a2ef79e16815d14930ecf3a0cacbc449f8b4581be6453ca',
     armv7l: '668bdf06acc1e02d9a2ef79e16815d14930ecf3a0cacbc449f8b4581be6453ca',
       i686: '1e1dc11e756309055e2086adac78f35a7979d8458cc8c3621aa1babd2a0cf37f',
     x86_64: '79faf57d69a900e81d35ce3517f4c5e7997f45925bbf31fc3bcd388084cc7e18'
  })

  depends_on 'python2'

  def self.build
    system "python2 setup.py build #{PY2_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python2 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
