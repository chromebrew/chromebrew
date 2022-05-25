require 'package'

class Libedit < Package
  description 'An autotooled and libtoolized port of the NetBSD Editline library (libedit).'
  homepage 'https://thrysoee.dk/editline/'
  version '20210910-3.1'
  compatibility 'all'
  license 'BSD-2'
  source_url 'https://thrysoee.dk/editline/libedit-20210910-3.1.tar.gz'
  source_sha256 '6792a6a992050762edcca28ff3318cdb7de37dccf7bc30db59fcd7017eed13c5'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libedit/20210910-3.1_armv7l/libedit-20210910-3.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libedit/20210910-3.1_armv7l/libedit-20210910-3.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libedit/20210910-3.1_i686/libedit-20210910-3.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libedit/20210910-3.1_x86_64/libedit-20210910-3.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '2b68bcfe634ef21dec0ff29215e1de3f0cd506041ccae30d6eea93fb946870e9',
     armv7l: '2b68bcfe634ef21dec0ff29215e1de3f0cd506041ccae30d6eea93fb946870e9',
       i686: '5397384d810b157b11ab640c2144cf35f0999039daf1fa9dfc7bea8ad84af6f1',
     x86_64: '41ec1b9f504bc593668bf88cde1eb85fcfd621397d7ec17c29ec686bc2238b5b'
  })

  depends_on 'glibc' # R

  def self.build
    system "./configure #{CREW_OPTIONS} \
            CPPFLAGS=\"-I#{CREW_PREFIX}/include/ncursesw\""
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    # Remove conflict with readline
    FileUtils.rm_f "#{CREW_DEST_MAN_PREFIX}/man3/history.3"
  end

  def self.check
    system 'make', 'check'
  end
end
