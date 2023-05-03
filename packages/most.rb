require 'package'

class Most < Package
  description 'MOST is a powerful paging program for Unix, VMS, MSDOS, and win32 systems.'
  homepage 'http://www.jedsoft.org/most/'
  version '5.2.0'
  license 'GPL-2'
  compatibility 'all'
  source_url "https://www.jedsoft.org/releases/most/most-#{version}.tar.gz"
  source_sha256 '9455aeb8f826fa8385c850dc22bf0f22cf9069b3c3423fba4bf2c6f6226d9903'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/most/5.2.0_armv7l/most-5.2.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/most/5.2.0_armv7l/most-5.2.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/most/5.2.0_i686/most-5.2.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/most/5.2.0_x86_64/most-5.2.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '12068a13f4a6dbf37c5a22a13834e306c5b91999af51e2a7cfa3ebc244473f1f',
     armv7l: '12068a13f4a6dbf37c5a22a13834e306c5b91999af51e2a7cfa3ebc244473f1f',
       i686: '2988c796e2d092d1026b2db237f084bb5562fa924884acac60182bad54764322',
     x86_64: '068c1106e867493a8a2b7566c08df4202e44e7e7d740e98fceac2e74346781a1'
  })

  depends_on 'glibc' # R
  depends_on 'slang' # R
  depends_on 'gcc' # R

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
