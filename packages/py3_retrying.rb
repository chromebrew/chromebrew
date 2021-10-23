require 'package'

class Py3_retrying < Package
  description 'Retrying simplifies the task of adding retry behavior to just about anything.'
  homepage 'https://github.com/rholder/retrying/'
  @_ver = '1.3.3'
  version "#{@_ver}-1"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/rholder/retrying.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_retrying/1.3.3_armv7l/py3_retrying-1.3.3-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_retrying/1.3.3_armv7l/py3_retrying-1.3.3-chromeos-armv7l.tpxz',
    i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_retrying/1.3.3-1_i686/py3_retrying-1.3.3-1-chromeos-i686.tpxz',
  x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_retrying/1.3.3-1_x86_64/py3_retrying-1.3.3-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'b740f5334db1044b55f4edc3876f7f88b631584abde4cb57f68f0a29285e4820',
     armv7l: 'b740f5334db1044b55f4edc3876f7f88b631584abde4cb57f68f0a29285e4820',
    i686: '7488a99c124e4945453a6a6f322b33ab533c0099d3421f51cc66758b1c8fc5a3',
  x86_64: 'e2ac41ff15cbf6ead31ceb6401e880be1f7a0674153c31209817730d414f1a7b'
  })

  depends_on 'py3_six'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
