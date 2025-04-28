require 'package'

class Texmaker < Package
  description 'Free cross-platform LaTeX editor'
  homepage 'https://www.xm1math.net/texmaker/index.html'
  version '5.0.4'
  license 'GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://www.xm1math.net/texmaker/texmaker-#{version}.tar.bz2"
  source_sha256 '1de3ab3f6d6bee37a7d0b528ca1cbb7ce8e7aef5ec6a4405aff2caf9d12bd0e2'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'abaea145d5395dfca8d9db4a6e402e95f205602771214b0d4c50f827f3791f5f',
     armv7l: 'abaea145d5395dfca8d9db4a6e402e95f205602771214b0d4c50f827f3791f5f',
     x86_64: '57a7116cf1ada18f1f9b53073d4081cb17e1e7805266899e26a1bd75a46968fa'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libglvnd' # R
  depends_on 'qt5_base' # R
  depends_on 'qt5_script' # R

  def self.build
    env = {
      'PREFIX'      => CREW_PREFIX,
      'DESKTOPDIR'  => "#{CREW_PREFIX}/share/applications",
      'ICONDIR'     => "#{CREW_PREFIX}/share/pixmaps",
      'METAINFODIR' => "#{CREW_PREFIX}/share/metainfo"
    }
    system env, 'qmake texmaker.pro'
    system "sed -i 's,\$(INSTALL_ROOT)/usr,#{CREW_DEST_PREFIX},g' Makefile"
    system "sed -i 's,-fPIC,-fPIC -Wno-error=implicit-function-declaration,g' Makefile"
    system 'make'
  end

  def self.install
    system 'make install'
  end
end
