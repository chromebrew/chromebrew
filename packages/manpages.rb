require 'package'

class Manpages < Package
  description 'The Linux man-pages project documents the Linux kernel and C library interfaces that are employed by user-space programs.'
  homepage 'https://www.kernel.org/doc/man-pages/'
  version '6.14-1'
  license 'man-pages, GPL-2+ and BSD'
  compatibility 'all'
  source_url "https://mirrors.edge.kernel.org/pub/linux/docs/man-pages/man-pages-#{version.split('-').first}.tar.xz"
  source_sha256 '71e13067b780044b2f372eec25f4209bc0413cc32af714141ef3d22d21eae8e3'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '565203367a47c96a422b733896ed90c1b2df90c28819b662d1e48d05b701af25',
     armv7l: '565203367a47c96a422b733896ed90c1b2df90c28819b662d1e48d05b701af25',
       i686: 'b2f0dee5392298725b6a1ecd872986f606f87a808ed32e60262d2df97716fe1a',
     x86_64: '2c72d590cbcf2e78b6153b16ddcdf1c2adde27a6499333be8ad89d0235ecc1ce'
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
