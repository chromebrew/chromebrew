require 'buildsystems/pip'

class Py3_greenlet < Pip
  description 'Greenlet provides lightweight in-process concurrent programming.'
  homepage 'https://greenlet.readthedocs.io/'
  version "3.5.4-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '22cdc6aecb1991469b75eaf4aa07cf449000c1db5b7c8cb12fd3694b0f539ea6',
     armv7l: '22cdc6aecb1991469b75eaf4aa07cf449000c1db5b7c8cb12fd3694b0f539ea6',
       i686: '3d53652394069962f88ca9fc09f6b01690b1c24ebb378b5f58dddbb13e73dd6f',
     x86_64: '9481e4c0663764654c42aab6a92f9f85302a752dac208f2864a0d1be22a52a64'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'py3_agate'
  depends_on 'py3_sqlalchemy'
  depends_on 'python3' => :logical

  no_source_build
end
