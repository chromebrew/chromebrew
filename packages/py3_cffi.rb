require 'package'

class Py3_cffi < Package
  description 'C Foreign Function Interface for Python calling C code.'
  homepage 'https://cffi.readthedocs.io/'
  @_ver = '1.14.6'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://files.pythonhosted.org/packages/2e/92/87bb61538d7e60da8a7ec247dc048f7671afe17016cd0008b3b710012804/cffi-1.14.6.tar.gz'
  source_sha256 'c9a875ce9d7fe32887784274dd533c57909b7b1dcadcc128a2ac21331a9765dd'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_cffi/1.14.6_armv7l/py3_cffi-1.14.6-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_cffi/1.14.6_armv7l/py3_cffi-1.14.6-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_cffi/1.14.6_x86_64/py3_cffi-1.14.6-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'b8fb5b6b8f7d866d80901792934034f6c1c145f06288e47600d16cbfe69a26e5',
     armv7l: 'b8fb5b6b8f7d866d80901792934034f6c1c145f06288e47600d16cbfe69a26e5',
     x86_64: 'd75a398ba7e4196843558c7f32a7692347d0c0d280fcd6b5fe5c5c285d5e441b'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
