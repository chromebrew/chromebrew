require 'package'

class Py3_xlsxwriter < Package
  description 'XlsxWriter is a Python module for creating Excel XLSX files.'
  homepage 'https://xlsxwriter.readthedocs.io/'
  @_ver = '3.0.1'
  version @_ver
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/jmcnamara/XlsxWriter.git'
  git_hashtag "RELEASE_#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_xlsxwriter/3.0.1_armv7l/py3_xlsxwriter-3.0.1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_xlsxwriter/3.0.1_armv7l/py3_xlsxwriter-3.0.1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_xlsxwriter/3.0.1_i686/py3_xlsxwriter-3.0.1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_xlsxwriter/3.0.1_x86_64/py3_xlsxwriter-3.0.1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'f0e1c5617d7bc8ba7cb261b000fcb509c02995f236944aa721629d30a07978d9',
     armv7l: 'f0e1c5617d7bc8ba7cb261b000fcb509c02995f236944aa721629d30a07978d9',
       i686: '3b5c866050589f0ff49ae139d3239acb4dc0a6927acc65e50e77d4a2f011b222',
     x86_64: 'daef6d75efcb5fdff86923b5e3a8b0a5d5194c38d2230f570a784a48694a8a8c'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
