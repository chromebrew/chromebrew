require 'package'

class Manpages < Package
  description 'The Linux man-pages project documents the Linux kernel and C library interfaces that are employed by user-space programs.'
  homepage 'https://www.kernel.org/doc/man-pages/'
  version '6.14'
  license 'man-pages, GPL-2+ and BSD'
  compatibility 'all'
  source_url "https://mirrors.edge.kernel.org/pub/linux/docs/man-pages/man-pages-#{version}.tar.xz"
  source_sha256 '71e13067b780044b2f372eec25f4209bc0413cc32af714141ef3d22d21eae8e3'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2b05865226b0d381499a4443dcaa9b88431a912f8bab5eb4f00c7886ba599194',
     armv7l: '2b05865226b0d381499a4443dcaa9b88431a912f8bab5eb4f00c7886ba599194',
       i686: '09dff001c7850f3299b965c018cea9fd52ecf87b99a375e1603f5831d69ff457',
     x86_64: '6fadf100adf6c382e8b52b00fcc561b16d733a5e651bac0f62b5cbaeea5cf91d'
  })

  depends_on 'man_db'

  def self.install
    system 'make', '-R', "DESTDIR=#{CREW_DEST_DIR}", "prefix=#{CREW_PREFIX}", 'install'
    # Remove conflicts with libxcrypt.
    FileUtils.rm "#{CREW_DEST_MAN_PREFIX}/man3/crypt.3"
    FileUtils.rm "#{CREW_DEST_MAN_PREFIX}/man3/crypt_r.3"
  end

  def self.postinstall
    ExitMessage.add "\nTry 'man printf' to see if it works.\n"
  end
end
