require 'package'

class Py3_olefile < Package
  description 'Olefile is a Python package to parse, read and write Microsoft OLE2 files.'
  homepage 'https://www.decalage.info/python/olefileio/'
  @_ver = '0.46'
  version "#{@_ver}-1"
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/decalage2/olefile.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_olefile/0.46-1_armv7l/py3_olefile-0.46-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_olefile/0.46-1_armv7l/py3_olefile-0.46-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_olefile/0.46-1_i686/py3_olefile-0.46-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_olefile/0.46-1_x86_64/py3_olefile-0.46-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'a29019a5f7fda813c7a5414208c99b3a9918ab8b0b8fc9733136a87eebb64e69',
     armv7l: 'a29019a5f7fda813c7a5414208c99b3a9918ab8b0b8fc9733136a87eebb64e69',
       i686: 'aa0c3b34328364e8029b4725e848c970d84cdbe6b018a37a881e3f7bcdd89fd3',
     x86_64: '88de4191dba01cd2919f43e30c62b68720e1acab11333cdf0261e74f3d57d25e'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
