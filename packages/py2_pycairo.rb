require 'package'

class Py2_pycairo < Package
  description 'Pycairo is a Python module providing bindings for the cairo graphics library.'
  homepage 'https://pycairo.readthedocs.io/'
  @_ver = '1.18.1'
  version @_ver
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/pygobject/pycairo.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py2_pycairo/1.18.1_armv7l/py2_pycairo-1.18.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py2_pycairo/1.18.1_armv7l/py2_pycairo-1.18.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py2_pycairo/1.18.1_i686/py2_pycairo-1.18.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py2_pycairo/1.18.1_x86_64/py2_pycairo-1.18.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '04d409c68c699d496a5b8a189eb65cfe90e921f5853b1f22c0549a9b2f1f916a',
     armv7l: '04d409c68c699d496a5b8a189eb65cfe90e921f5853b1f22c0549a9b2f1f916a',
       i686: '6dda826d659758343fe36f257283811cfc0c55bffd58983c550d48c5bba3b2f4',
     x86_64: '2265a6ad25ca47bca4217dd75a49a753f4e0e9cdeb339f3774769aebd18a5a61'
  })

  depends_on 'python2'
  depends_on 'cairo'
  depends_on 'meson' => :build

  def self.build
    system "meson setup \
            #{CREW_MESON_OPTIONS} \
            -Dpython=python2 \
            builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
