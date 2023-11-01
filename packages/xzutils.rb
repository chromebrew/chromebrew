require 'buildsystems/autotools'

class Xzutils < Autotools
  description 'XZ Utils is free general-purpose data compression software with a high compression ratio.'
  homepage 'http://tukaani.org/xz/'
  version '5.4.5'
  license 'public-domain, LGPL-2.1+ and GPL-2+'
  compatibility 'all'
  source_url 'https://tukaani.org/xz/xz-5.4.5.tar.gz'
  source_sha256 '135c90b934aee8fbc0d467de87a05cb70d627da36abe518c357a873709e5b7d6'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xzutils/5.4.5_armv7l/xzutils-5.4.5-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xzutils/5.4.5_armv7l/xzutils-5.4.5-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xzutils/5.4.5_i686/xzutils-5.4.5-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xzutils/5.4.5_x86_64/xzutils-5.4.5-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'f8226905f3d3ebb242a704d4af6eb02258e916fc1615fdf9c8522804c62bb32e',
     armv7l: 'f8226905f3d3ebb242a704d4af6eb02258e916fc1615fdf9c8522804c62bb32e',
       i686: '35ae2f4c29f9244fd9157b3a6afc6c30cc3615e7ffc45a3c74bcee48de09b809',
     x86_64: '28b3de7aee6c9996541ef99585f221cff7e3a4c0a376cf355cdf12cfb22b4b77'
  })

  depends_on 'autoconf_archive' => :build
  depends_on 'glibc' # R

  configure_options '--enable-shared'
  run_tests
end
