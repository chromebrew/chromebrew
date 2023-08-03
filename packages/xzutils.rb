require 'buildsystems/autotools'

class Xzutils < Autotools
  description 'XZ Utils is free general-purpose data compression software with a high compression ratio.'
  homepage 'http://tukaani.org/xz/'
  version '5.4.4'
  license 'public-domain, LGPL-2.1+ and GPL-2+'
  compatibility 'all'
  source_url 'https://tukaani.org/xz/xz-5.4.4.tar.gz'
  source_sha256 'aae39544e254cfd27e942d35a048d592959bd7a79f9a624afb0498bb5613bdf8'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xzutils/5.4.4_armv7l/xzutils-5.4.4-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xzutils/5.4.4_armv7l/xzutils-5.4.4-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xzutils/5.4.4_i686/xzutils-5.4.4-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xzutils/5.4.4_x86_64/xzutils-5.4.4-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'c47ede32e4586414aae59b89610925108b343c9f372ba774975c0f32d34b1cd7',
     armv7l: 'c47ede32e4586414aae59b89610925108b343c9f372ba774975c0f32d34b1cd7',
       i686: '35f444be4703e8fccf53fd194943ae3d50497bf4eda676461d942c6be1e06ca9',
     x86_64: 'e43ed33f516fcba977a417c11f00b32fd481a580aedef32347e723e99191d114'
  })

  depends_on 'autoconf_archive' => :build
  depends_on 'glibc' # R

  configure_options '--enable-shared'
  run_tests
end
