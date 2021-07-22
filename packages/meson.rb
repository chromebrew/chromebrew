require 'package'

class Meson < Package
  description 'Meson is an open source build system meant to be both extremely fast and user friendly.'
  homepage 'https://mesonbuild.com/'
  @_ver = '0.58.2'
  version @_ver
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/mesonbuild/meson.git'
  git_hashtag @_ver

  depends_on 'ninja'
  depends_on 'samurai'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
    FileUtils.mv "#{CREW_DEST_PREFIX}/bin/meson", "#{CREW_DEST_PREFIX}/bin/meson.py"
    system "python3 -m nuitka --show-progress \
            --show-scons \
            --follow-imports \
            --prefer-source-code \
            #{CREW_DEST_PREFIX}/bin/meson.py \
            -o #{CREW_DEST_PREFIX}/bin/meson"
    FileUtils.rm "#{CREW_DEST_PREFIX}/bin/meson.py"
  end
end
