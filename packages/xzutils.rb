require 'package'

class Xzutils < Package
  description 'XZ Utils is free general-purpose data compression software with a high compression ratio.'
  homepage 'http://tukaani.org/xz/'
  version '5.4.2'
  license 'public-domain, LGPL-2.1+ and GPL-2+'
  compatibility 'all'
  source_url 'https://tukaani.org/xz/xz-5.4.2.tar.gz'
  source_sha256 '87947679abcf77cc509d8d1b474218fd16b72281e2797360e909deaee1ac9d05'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xzutils/5.4.2_armv7l/xzutils-5.4.2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xzutils/5.4.2_armv7l/xzutils-5.4.2-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xzutils/5.4.2_i686/xzutils-5.4.2-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xzutils/5.4.2_x86_64/xzutils-5.4.2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '7641b6c7b1795b5ceb9fc69a07709383af08447d19b72282431edc8f25d83148',
     armv7l: '7641b6c7b1795b5ceb9fc69a07709383af08447d19b72282431edc8f25d83148',
       i686: '88e98f1c8524bf5cd6080b05b5bf9f1d7c38224abea6c216783288aebf7266d3',
     x86_64: '0ec4d59acf5bab9c6ce3a2bef1fe0721bcf9eb8df2103805eb5c2ed860b6ddf1'
  })

  depends_on 'autoconf_archive' => :build
  depends_on 'glibc' # R

  def self.build
    system '[ -x configure ] || NOCONFIGURE=1 ./autogen.sh --no-po4a'
    system "#{CREW_ENV_OPTIONS} \
      ./configure \
      #{CREW_OPTIONS} \
      --disable-docs \
      --enable-shared"
    system 'make'
  end

  def self.check
    system 'make', 'check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
