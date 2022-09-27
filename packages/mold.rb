# Adapted from Arch Linux mold PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/mold/trunk/PKGBUILD

require 'package'

class Mold < Package
  description 'A Modern Linker'
  homepage 'https://github.com/rui314/mold'
  version '1.5.0'
  compatibility 'all'
  source_url 'https://github.com/rui314/mold.git'
  git_hashtag "v#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mold/1.5.0_armv7l/mold-1.5.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mold/1.5.0_armv7l/mold-1.5.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mold/1.5.0_i686/mold-1.5.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mold/1.5.0_x86_64/mold-1.5.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '8f1965c6201a432804cc9b753163c2649df67106996d9adc5a983bdb22df12a5',
     armv7l: '8f1965c6201a432804cc9b753163c2649df67106996d9adc5a983bdb22df12a5',
       i686: '212d9bdbdc56de6b4ef2fc8b679051513f3111e16ea645896e28a80872cfa405',
     x86_64: '0130c27743f8950f020a5cd0c5aa90119f37e01e5b69e99328b90e321bc091d1'
  })

  depends_on 'zlibpkg' # R
  depends_on 'glibc' # R
  depends_on 'openssl' # R
  depends_on 'gcc' # R
  depends_on 'xxhash' => :build
  no_env_options

  def self.build
    FileUtils.mkdir_p 'builddir'
    Dir.chdir('builddir') do
      system "cmake #{CREW_CMAKE_OPTIONS} \
        -DBUILD_TESTING=OFF \
        -DMOLD_USE_MOLD=ON \
        -DMOLD_LTO=ON \
        -Wno-dev \
        ../ -G Ninja"
    end
    system 'samu -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
  end
end
