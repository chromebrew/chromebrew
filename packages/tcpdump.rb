require 'package'

class Tcpdump < Package
  description 'A powerful command-line packet analyzer.'
  homepage 'http://www.tcpdump.org/'
  version '4.99.4'
  license 'BSD'
  compatibility 'all'
  source_url 'https://www.tcpdump.org/release/tcpdump-4.99.4.tar.gz'
  source_sha256 '0232231bb2f29d6bf2426e70a08a7e0c63a0d59a9b44863b7f5e2357a6e49fea'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'baa219a275ccc1a3f96c916257fce94b79694595aabf85617e37767c9b9eb322',
     armv7l: 'baa219a275ccc1a3f96c916257fce94b79694595aabf85617e37767c9b9eb322',
       i686: 'a885e93725c249a3719233c0ea8b75958b143f3b05daf24720ff89a473940126',
     x86_64: '60db668da80170da1388bcbb66f168f1158e16775d8ad7cdc70296be1b34c4fb'
  })

  depends_on 'libcap'
  depends_on 'libcap_ng'
  depends_on 'libpcap'
  depends_on 'openssl'

  def self.build
    system "./configure #{CREW_OPTIONS} --with-user=#{USER}"
    system 'make'
  end

  def self.check
    system 'make check || true'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
