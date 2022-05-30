require 'package'

class Py3_pep517 < Package
  description 'Python PEP517 is an API to call PEP 517 hooks for building Python packages '
  homepage 'https://pep517.readthedocs.io/'
  @_ver = '0.12.0'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pypa/pep517.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pep517/0.12.0_armv7l/py3_pep517-0.12.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pep517/0.12.0_armv7l/py3_pep517-0.12.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pep517/0.12.0_i686/py3_pep517-0.12.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pep517/0.12.0_x86_64/py3_pep517-0.12.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '3859ce14eaff1b97a1e16dcdf742c039d1c8e76e36616a7b2482ec83df10de54',
     armv7l: '3859ce14eaff1b97a1e16dcdf742c039d1c8e76e36616a7b2482ec83df10de54',
       i686: '8bd85456f842b652281dec2adf8535fde039c08ab045496ba03107b62b0a26aa',
     x86_64: '3449cac3f9fde2537161811473c50566d823c8dd5e423db4cc64bf1538d0ef46'
  })

  depends_on 'py3_tomli'

  def self.build
    system "python3 -m build #{PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 -m installer #{PY3_INSTALLER_OPTIONS}"
  end
end
