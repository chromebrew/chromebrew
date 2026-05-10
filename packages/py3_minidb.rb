require 'buildsystems/pip'

class Py3_minidb < Pip
  description 'Minidb is a simple SQLite3-based store for Python objects.'
  homepage 'https://thp.io/2010/minidb/'
  version "2.0.8-#{CREW_PY_VER}"
  license 'ISC'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '15ed025630a1641e898647aad3eb43df6af8d0aa9fe473926b0a2b842e6cf568',
     armv7l: '15ed025630a1641e898647aad3eb43df6af8d0aa9fe473926b0a2b842e6cf568',
       i686: '916d635b5a4956a6b71246c440fd45c970dad52c225c12feba28353f99414d7f',
     x86_64: 'cd1befa2c3815b0628521f051539432649cfe0e169733849254bd340ac2d0b2b'
  })

  depends_on 'python3' => :logical

  no_source_build
end
