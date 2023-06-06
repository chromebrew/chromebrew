require 'package'

class Dav1d < Package
  description '**dav1d** is a new **AV1** cross-platform **d**ecoder, open-source, and focused on speed and correctness.'
  homepage 'https://code.videolan.org/videolan/dav1d'
  @_ver = '1.1.0'
  version @_ver
  license 'BSD-2'
  compatibility 'all'
  source_url 'https://code.videolan.org/videolan/dav1d.git'
  git_hashtag version

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/dav1d/1.1.0_armv7l/dav1d-1.1.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/dav1d/1.1.0_armv7l/dav1d-1.1.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/dav1d/1.1.0_i686/dav1d-1.1.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/dav1d/1.1.0_x86_64/dav1d-1.1.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '7b35f1b4e3fa2444e4cb4d9b5b8e0fb2915ae06930da88cf49446fae7002ca40',
     armv7l: '7b35f1b4e3fa2444e4cb4d9b5b8e0fb2915ae06930da88cf49446fae7002ca40',
       i686: '608c26bfe4f856f00b3097614244d58c5ee6a187ecd9c26c46dae22e4013dbbc',
     x86_64: '0ed6daca981af6f24609789a37deb0e910fbcd6afdb6b3f7fc81d8c5dfc8e2ec'
  })

  depends_on 'nasm' => :build
  depends_on 'glibc' # R
  depends_on 'gcc_lib' # R

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
      builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
