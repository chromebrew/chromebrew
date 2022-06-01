# Adapted from Arch Linux gnulib-git PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=gnulib-git

require 'package'

class Gnulib_git < Package
  description 'GNU Portability Library'
  homepage 'http://www.gnu.org/software/gnulib'
  version 'v0.1-d6a07b4'
  license 'custom'
  compatibility 'all'
  source_url 'https://git.savannah.gnu.org/git/gnulib.git'
  git_hashtag 'd6a07b4dc21b3118727743142c678858df442853'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnulib_git/v0.1-d6a07b4_armv7l/gnulib_git-v0.1-d6a07b4-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnulib_git/v0.1-d6a07b4_armv7l/gnulib_git-v0.1-d6a07b4-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnulib_git/v0.1-d6a07b4_i686/gnulib_git-v0.1-d6a07b4-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnulib_git/v0.1-d6a07b4_x86_64/gnulib_git-v0.1-d6a07b4-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '14dc5ef4dae60f1d48ea49849f66cacda35c901f57cd401f780715517286acf6',
     armv7l: '14dc5ef4dae60f1d48ea49849f66cacda35c901f57cd401f780715517286acf6',
       i686: '26cd24849f625113a04995fcc4923710a3e54102368770e6678bcfdb3d3bc040',
     x86_64: '3215f4e675b309772d8d4b334e8ec5de4a94a463054aa7262b85adb1ef9d359f'
  })

  def self.patch
    system "sed -i \"/^[ ]*gnulib_dir=/s,\\`[^\\`]*\\`,#{CREW_PREFIX}/share/gnulib-git,\" gnulib-tool"
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/gnulib-git"
    FileUtils.install %w[check-module gnulib-tool], "#{CREW_DEST_PREFIX}/share/gnulib-git/", mode: 0o755
    FileUtils.cp_r %w[build-aux lib m4 modules top], "#{CREW_DEST_PREFIX}/share/gnulib-git"

    FileUtils.cp_r %w[doc tests], "#{CREW_DEST_PREFIX}/share/gnulib-git/"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.ln "#{CREW_DEST_PREFIX}/share/gnulib-git/gnulib-tool", "#{CREW_DEST_PREFIX}/bin/"
    FileUtils.ln "#{CREW_DEST_PREFIX}/share/gnulib-git/check-module", "#{CREW_DEST_PREFIX}/bin/"
  end
end
