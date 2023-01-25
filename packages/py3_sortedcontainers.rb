require 'package'

class Py3_sortedcontainers < Package
  description 'Python Sorted Container Types: Sorted List, Sorted Dict, and Sorted Set'
  homepage 'http://www.grantjenks.com/docs/sortedcontainers/'
  @_ver = '2.4.0'
  version "#{@_ver}-py3.11"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/grantjenks/python-sortedcontainers.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_sortedcontainers/2.4.0-py3.11_armv7l/py3_sortedcontainers-2.4.0-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_sortedcontainers/2.4.0-py3.11_armv7l/py3_sortedcontainers-2.4.0-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_sortedcontainers/2.4.0-py3.11_i686/py3_sortedcontainers-2.4.0-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_sortedcontainers/2.4.0-py3.11_x86_64/py3_sortedcontainers-2.4.0-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'cd8f715db7823fa1c69c0eac8ff7fc1df5b47292af12ba274f3c4d62ba17e7b3',
     armv7l: 'cd8f715db7823fa1c69c0eac8ff7fc1df5b47292af12ba274f3c4d62ba17e7b3',
       i686: 'ef8a370d91c50d30e723f90416a4a28d18f332ac4909b37356df4938e561cb0e',
     x86_64: '8c5e1f3e934aaf3759e075099f1ad8b17676b94a862a69c1dbe7efcbb6ce6548'
  })

  depends_on 'python3' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
