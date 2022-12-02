require 'package'

class Py3_semantic_version < Package
  description 'Semantic version implements the SemVer scheme.'
  homepage 'https://github.com/rbarrois/python-semanticversion/'
  @_ver = '2.10.0'
  version "#{@_ver}-py3.11"
  license 'BSD-2'
  compatibility 'all'
  source_url 'https://github.com/rbarrois/python-semanticversion.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_semantic_version/2.10.0-py3.11_armv7l/py3_semantic_version-2.10.0-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_semantic_version/2.10.0-py3.11_armv7l/py3_semantic_version-2.10.0-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_semantic_version/2.10.0-py3.11_i686/py3_semantic_version-2.10.0-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_semantic_version/2.10.0-py3.11_x86_64/py3_semantic_version-2.10.0-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '8262047e803c27d37e365b09a0cbf307f85784d01e51e87c6269276751e3a5d6',
     armv7l: '8262047e803c27d37e365b09a0cbf307f85784d01e51e87c6269276751e3a5d6',
       i686: 'a30b73c29cf1c58c37c33f09a2311b1a7822dec1e470bbe8bde6c84ed45ad8ea',
     x86_64: 'a1ff66d7b04d0482c5c5f8e6f60b7adb02516176b5d44e9355ba57505fbcc37e'
  })

  depends_on 'python3' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
