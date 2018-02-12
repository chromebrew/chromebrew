require 'package'

class Cryptsetup < Package
  description 'The cryptsetup utility is used to conveniently setup disk en-/decryption based on DMCrypt kernel module.'
  homepage 'https://gitlab.com/cryptsetup/cryptsetup'
  version '2.0.1'
  source_url 'https://www.kernel.org/pub/linux/utils/cryptsetup/v2.0/cryptsetup-2.0.1.tar.xz'
  source_sha256 '41d188092c52e23d576af41cf0cfe0555d8f7efa21598d4c57c56ea1b6d9c975'

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

  def self.check
    system "make", "check"
  end
end
