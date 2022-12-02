require 'package'

class Py3_et_xmlfile < Package
  description 'Et-xmlfile is an implementation of lxml\'s xmlfile module for the standard library\'s ElementTree.'
  homepage 'https://openpyxl.readthedocs.io/'
  @_ver = '1.1.0'
  version "#{@_ver}-py3.11"
  license 'MIT'
  compatibility 'all'
  source_url 'https://files.pythonhosted.org/packages/3d/5d/0413a31d184a20c763ad741cc7852a659bf15094c24840c5bdd1754765cd/et_xmlfile-1.1.0.tar.gz'
  source_sha256 '8eb9e2bc2f8c97e37a2dc85a09ecdcdec9d8a396530a6d5a33b30b9a92da0c5c'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_et_xmlfile/1.1.0-py3.11_armv7l/py3_et_xmlfile-1.1.0-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_et_xmlfile/1.1.0-py3.11_armv7l/py3_et_xmlfile-1.1.0-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_et_xmlfile/1.1.0-py3.11_i686/py3_et_xmlfile-1.1.0-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_et_xmlfile/1.1.0-py3.11_x86_64/py3_et_xmlfile-1.1.0-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '0a04cfcb7030d2e8bb9243d9e41a07c6d2ba52a6a471e4ba9f82c2ab0ab30576',
     armv7l: '0a04cfcb7030d2e8bb9243d9e41a07c6d2ba52a6a471e4ba9f82c2ab0ab30576',
       i686: '4f46b8ec33cfa7f830d0326684c2d2da020ad1a8c59f7b1a4ab1850bbd657246',
     x86_64: 'c9c8aee7664243e52b4b0222cbf5e7837e535ce68beec353671824ee875957f0'
  })

  depends_on 'python3' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
