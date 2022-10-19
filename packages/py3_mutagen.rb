require 'package'

class Py3_mutagen < Package
  description 'Python module for handling audio metadata'
  homepage 'https://mutagen.readthedocs.io/'
  @_ver = '1.46.0'
  version @_ver
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/quodlibet/mutagen.git'
  git_hashtag "release-#{@_ver}"

  depends_on 'py3_setuptools' => :build

  def self.build
    system "SETUPTOOLS_SCM_PRETEND_VERSION=#{@_ver} python3 -m build #{PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 -m installer #{PY3_INSTALLER_OPTIONS}"
  end
end
