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
    system "python3 -m nuitka --show-progress \
            --show-scons \
            --follow-imports \
            --prefer-source-code \
            meson.py \
            -o meson"
  end

  def self.install
    FileUtils.mkdir "#{CREW_DEST_PREFIX}/bin/"
    FileUtils.cp "meson", "#{CREW_DEST_PREFIX}/bin/meson"
  end
end
