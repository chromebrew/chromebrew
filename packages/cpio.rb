require 'package'

class Cpio < Package
  description 'GNU cpio copies files into or out of a cpio or tar archive. The archive can be another file on the disk, a magnetic tape, or a pipe.'
  homepage 'https://www.gnu.org/software/cpio/'
  version '2.13'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/cpio/cpio-2.13.tar.bz2'
  source_sha256 'eab5bdc5ae1df285c59f2a4f140a98fc33678a0bf61bdba67d9436ae26b46f6d'

  def self.patch
    # these patches allow -flto to work
    _url = "https://github.com/alpinelinux/aports/raw/dfc99097d6372098d36f33a1c80961d3639293f2/community/cpio"
    downloader "#{_url}/CVE-2021-38185.patch", "a92b9b3367a90cb66e08674df9b62dfacafa85885bfe5b16de0517e1694a2502"
    downloader "#{_url}/CVE-2021-38185-2.patch", "2a2b3564d3910dfa7b0f595af6a69ed5a664443e786fc770a9a51d453b7af6d1"
    downloader "#{_url}/CVE-2021-38185-3.patch", "3b337b844cc37043cb49b115fcf0efa0bc6a042eee7ef7a074c74b56d3978156"
    downloader "#{_url}/gcc-10.patch", "68181f05736e9165493320f5213f76410c496a04ca03a3a7da3eb6f8d0c4e4c1"
    Dir['*.patch'].each do |filename|
      system "patch -Np1 -i #{filename} || true" # some patch hunks fail
    end
  end

  def self.build
    system "./configure #{CREW_OPTIONS} \
              --enable-mt" # magnetic tape, not manifest tool
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    system 'make', 'check'
  end
end
