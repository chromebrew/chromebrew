require 'package'

class Cpio < Package
  description 'GNU cpio copies files into or out of a cpio or tar archive. The archive can be another file on the disk, a magnetic tape, or a pipe.'
  homepage 'https://www.gnu.org/software/cpio/'
  version '2.13'
  compatibility 'all'
  license 'GPL-3'
  source_url 'https://ftpmirror.gnu.org/cpio/cpio-2.13.tar.bz2'
  source_sha256 'eab5bdc5ae1df285c59f2a4f140a98fc33678a0bf61bdba67d9436ae26b46f6d'

  binary_url({
    i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cpio/2.13_i686/cpio-2.13-chromeos-i686.tar.zst',
  x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cpio/2.13_x86_64/cpio-2.13-chromeos-x86_64.tar.zst',
 aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cpio/2.13_armv7l/cpio-2.13-chromeos-armv7l.tar.zst',
  armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cpio/2.13_armv7l/cpio-2.13-chromeos-armv7l.tar.zst'
  })
  binary_sha256({
    i686: 'af635bbef1f4b56a2ad457e97f0a4794e3b854784f4e86375fe3dea6905e0407',
  x86_64: '11265e9d8eb7760d0d9e98e80860056793243e622cdf82d4ed2a2ef51722f8ee',
 aarch64: '61e781fe2ff468ae371bc7058f0d970a299d763012bb285895826b099ace958a',
  armv7l: '61e781fe2ff468ae371bc7058f0d970a299d763012bb285895826b099ace958a'
  })

  def self.patch
    # these patches allow -flto to work
    _url = 'https://github.com/alpinelinux/aports/raw/dfc99097d6372098d36f33a1c80961d3639293f2/community/cpio'
    downloader "#{_url}/CVE-2021-38185.patch", 'a92b9b3367a90cb66e08674df9b62dfacafa85885bfe5b16de0517e1694a2502'
    downloader "#{_url}/CVE-2021-38185-2.patch", '2a2b3564d3910dfa7b0f595af6a69ed5a664443e786fc770a9a51d453b7af6d1'
    downloader "#{_url}/CVE-2021-38185-3.patch", '3b337b844cc37043cb49b115fcf0efa0bc6a042eee7ef7a074c74b56d3978156'
    downloader "#{_url}/gcc-10.patch", '68181f05736e9165493320f5213f76410c496a04ca03a3a7da3eb6f8d0c4e4c1'
    Dir['CVE-2021-38185.patch', 'CVE-2021-38185-2.patch', 'CVE-2021-38185-3.patch', 'gcc-10.patch'].each do |filename|
      system "patch -Np1 -i #{filename}"
    end
  end

  def self.build
    system "./configure #{CREW_OPTIONS} \
              --enable-mt" # magnetic tape, not manifest tool
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system 'make', 'check'
  end
end
