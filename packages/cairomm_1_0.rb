require 'package'

class Cairomm_1_0 < Package
  description 'The Cairomm package provides a C++ interface to Cairo.'
  homepage 'https://www.cairographics.org/'
  version '1.14.4'
  license 'LGPL-2+'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/cairo/cairomm.git'
  git_hashtag version

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cairomm_1_0/1.14.4_armv7l/cairomm_1_0-1.14.4-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cairomm_1_0/1.14.4_armv7l/cairomm_1_0-1.14.4-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cairomm_1_0/1.14.4_i686/cairomm_1_0-1.14.4-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cairomm_1_0/1.14.4_x86_64/cairomm_1_0-1.14.4-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '476734904312bcf2ab5f68b6e01c21d9cec2ce8a193bb72460a5ff4b6963d2f6',
     armv7l: '476734904312bcf2ab5f68b6e01c21d9cec2ce8a193bb72460a5ff4b6963d2f6',
       i686: '012bc214aeabf2221851723ffff25cbe9d3cb325cb44d954e4ce5e63f961458a',
     x86_64: '55cce265874cfb769db0f0c7583d6aaef29eb4919431c10d8db4adaacf94b289'
  })

  depends_on 'cairo' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'harfbuzz' # R
  depends_on 'libsigcplusplus' # R
  depends_on 'libxrender' => :build
  depends_on 'libxxf86vm' => :build

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
    -Dbuild-documentation=false \
    -Dbuild-examples=false \
    -Dbuild-tests=false \
    builddir"
    system 'meson configure --no-pager builddir'
    system "#{CREW_NINJA} -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
  end
end
