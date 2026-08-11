require 'buildsystems/pip'

class Py3_greenlet < Pip
  description 'Greenlet provides lightweight in-process concurrent programming.'
  homepage 'https://greenlet.readthedocs.io/'
  version "3.5.5-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7b34bc538d27dadf05c8d0babb1f5cbc9bf8c3ad91b4e1ade28eda8666c49f51',
     armv7l: '7b34bc538d27dadf05c8d0babb1f5cbc9bf8c3ad91b4e1ade28eda8666c49f51',
       i686: '4c070eec4a892755b87e3999377096cee6641bf6251f71ae5e83596de64f9020',
     x86_64: '3c9fa33d5eec12fd5c751db8e615bf4f0a3066426730a7036bd96cedbbb16c04'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'py3_agate'
  depends_on 'py3_sqlalchemy'
  depends_on 'python3' => :logical

  no_source_build
end
