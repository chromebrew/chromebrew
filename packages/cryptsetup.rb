require 'package'

class Cryptsetup < Package
  description 'The cryptsetup utility is used to conveniently setup disk en-/decryption based on DMCrypt kernel module.'
  homepage 'https://gitlab.com/cryptsetup/cryptsetup'
  version '2.0.1'
  source_url 'https://www.kernel.org/pub/linux/utils/cryptsetup/v2.0/cryptsetup-2.0.1.tar.xz'
  source_sha256 '41d188092c52e23d576af41cf0cfe0555d8f7efa21598d4c57c56ea1b6d9c975'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/cryptsetup-2.0.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/cryptsetup-2.0.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/cryptsetup-2.0.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/cryptsetup-2.0.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'cfe406001f6f010a655a9b2a55ff3be03e29d5e2ee79a757a46bba3809b4ba01',
     armv7l: 'cfe406001f6f010a655a9b2a55ff3be03e29d5e2ee79a757a46bba3809b4ba01',
       i686: '8cd48aa7e01d5e6854e78a888f97478c530c18ee450809c9cc7867801a6cf3fa',
     x86_64: 'fd33e4276dad999973373c75c802a0561b32a2472cc02c99b6b7bca07eb61eff',
  })

  depends_on 'util_linux'
  depends_on 'lvm2'
  depends_on 'jsonc'
  depends_on 'libgcrypt'
  depends_on 'popt'

  def self.build
    system "./configure", "--prefix=#{CREW_PREFIX}", "--libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

end
