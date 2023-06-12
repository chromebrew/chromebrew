require 'package'

class Dav1d < Package
  description '**dav1d** is a new **AV1** cross-platform **d**ecoder, open-source, and focused on speed and correctness.'
  homepage 'https://code.videolan.org/videolan/dav1d'
  @_ver = '1.2.1'
  version @_ver
  license 'BSD-2'
  compatibility 'all'
  source_url 'https://code.videolan.org/videolan/dav1d.git'
  git_hashtag version

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/dav1d/1.2.1_armv7l/dav1d-1.2.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/dav1d/1.2.1_armv7l/dav1d-1.2.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/dav1d/1.2.1_i686/dav1d-1.2.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/dav1d/1.2.1_x86_64/dav1d-1.2.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '26bd9381e2090695d06ab47303371ec71104c9f68ee5d703830374bd9940008b',
     armv7l: '26bd9381e2090695d06ab47303371ec71104c9f68ee5d703830374bd9940008b',
       i686: '710a074d248406d6ccf0ed3258e01115fcf1c7948b414f317454c3550c82dde0',
     x86_64: '4fb262aaff4c92ca1032b7a9c666530e1470da05ef88c8db1b1a1e1a5ce47777'
  })

  depends_on 'nasm' => :build
  depends_on 'glibc' # R
  depends_on 'gcc_lib' # R

  def self.build
    system "mold -run meson setup #{CREW_MESON_OPTIONS.gsub('-mfpu=vfpv3-d16', '-mfpu=neon-fp16')} \
      builddir"
    system 'meson configure builddir'
    system "#{CREW_NINJA} -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
  end
end
