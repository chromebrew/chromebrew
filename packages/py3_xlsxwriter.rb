require 'package'

class Py3_xlsxwriter < Package
  description 'XlsxWriter is a Python module for creating Excel XLSX files.'
  homepage 'https://xlsxwriter.readthedocs.io/'
  @_ver = '3.0.1'
  version "#{@_ver}-py3.11"
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/jmcnamara/XlsxWriter.git'
  git_hashtag "RELEASE_#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_xlsxwriter/3.0.1-py3.11_armv7l/py3_xlsxwriter-3.0.1-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_xlsxwriter/3.0.1-py3.11_armv7l/py3_xlsxwriter-3.0.1-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_xlsxwriter/3.0.1-py3.11_i686/py3_xlsxwriter-3.0.1-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_xlsxwriter/3.0.1-py3.11_x86_64/py3_xlsxwriter-3.0.1-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '39bc69504dceaf5d37291a13d529ddfceac9ed821fa5c37dd02a70e854f39d76',
     armv7l: '39bc69504dceaf5d37291a13d529ddfceac9ed821fa5c37dd02a70e854f39d76',
       i686: '638b1d6a322fd9255fc4ac2a04eb3c97a78ddac3b637cede8846629742160fae',
     x86_64: '80de04bc94504270d869de1d9111e601289df686663be94754b3744013019719'
  })

  depends_on 'python3' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
