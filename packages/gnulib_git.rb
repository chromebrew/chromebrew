require 'package'

class Gnulib_git < Package
  description 'GNU Portability Library'
  homepage 'http://www.gnu.org/software/gnulib/'
  version 'v0.1-8724b44'
  license 'custom'
  compatibility 'all'
  source_url 'https://git.savannah.gnu.org/git/gnulib.git'
  git_hashtag '8724b4400aacd18cbf9697aec79e1e94a081ddd9'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4490352f727555b64f7452b45918cc6617f80ee5df5b0963e4be11ed78556073',
     armv7l: '4490352f727555b64f7452b45918cc6617f80ee5df5b0963e4be11ed78556073',
       i686: 'bc1aa4bcb0695201534d506f4c60d03d10de0d0c7872b98f438eb7a85e32ee04',
     x86_64: '1fd7cdfdc6f82a9557f67ee61f478bec0fb2a7fd7dff6b4bcbe0b5096996d1b2'
  })

  print_source_bashrc

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

    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/env.d/"
    # Found the suggestion for setting ACLOCAL_PATH in:
    # https://salsa.debian.org/science-team/mpfi/-/blob/master/debian/rules?ref_type=heads
    File.write "#{CREW_DEST_PREFIX}/etc/env.d/gnulib", <<~GNULIB_ENV_EOF
      ACLOCAL_PATH=#{CREW_PREFIX}/share/gnulib-git/m4
    GNULIB_ENV_EOF
  end
end
