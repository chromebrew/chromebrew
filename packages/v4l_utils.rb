require 'buildsystems/meson'

class V4l_utils < Meson
  description 'The v4l-utils are a series of packages for handling media devices.'
  homepage 'https://www.linuxtv.org/wiki/index.php/V4l-utils'
  version '1.32.0'
  license 'GPL-2+ and LGPL-2.1+'
  compatibility 'all'
  source_url 'https://git.linuxtv.org/v4l-utils.git'
  git_hashtag "v4l-utils-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1474d9025dd6b2556ae9d0e17642d667dd93a84fcbe69611e021d130a63fb076',
     armv7l: '1474d9025dd6b2556ae9d0e17642d667dd93a84fcbe69611e021d130a63fb076',
       i686: '4365acd571853d7503705df7a05be2fc3bf877597d8c7cfe27022431437f52c7',
     x86_64: '5869adb6eb9cba7f35969773379cfda1e7d07ad3e2a09fe102a1c50d71d05ebf'
  })

  depends_on 'eudev' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libjpeg_turbo'

  def self.patch
    system "find . -name '*.pl' -exec sed -i 's,/usr/bin/perl,#{CREW_PREFIX}/bin/perl,g' {} +"
  end
end
