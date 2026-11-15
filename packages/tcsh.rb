require 'buildsystems/autotools'

class Tcsh < Autotools
  description 'tcsh is a csh compatible shell with file name completion and command line editing.'
  homepage 'https://www.tcsh.org/'
  version '6.24.16'
  license 'BSD'
  compatibility 'all'
  source_url "https://astron.com/pub/tcsh/tcsh-#{version}.tar.gz"
  source_sha256 '4208cf4630fb64d91d81987f854f9570a5a0e8a001a92827def37d0ed8f37364'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '358b1c3ba4a502ba79edaf40231d7d82dac41aef570d19aa9f6f040ed2ade807',
     armv7l: '358b1c3ba4a502ba79edaf40231d7d82dac41aef570d19aa9f6f040ed2ade807',
       i686: '67afc7cb104549ff3862cd660a9610c6d3cc4cde11520e083647aa0c6490d9ab',
     x86_64: '57d4afb56cbeacc60e2d1a594c6f0a072f3e3bab71440bd2333d5f3f4076bb45'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'libxcrypt' => :executable
  depends_on 'ncurses' => :executable
end
