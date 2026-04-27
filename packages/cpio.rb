require 'buildsystems/autotools'

class Cpio < Autotools
  description 'GNU cpio copies files into or out of a cpio or tar archive. The archive can be another file on the disk, a magnetic tape, or a pipe.'
  homepage 'https://www.gnu.org/software/cpio/'
  version '2.15-ef694f7'
  license 'GPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://https.git.savannah.gnu.org/git/cpio.git'
  git_hashtag 'ef694f7bcc60d2b92e5737e31790791ff4de20f3'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '170bd5a0e64bc2a21f5fffa5d6cac9bfb5886b8712719d90a6ad0dcc7fc56767',
     armv7l: '170bd5a0e64bc2a21f5fffa5d6cac9bfb5886b8712719d90a6ad0dcc7fc56767',
     x86_64: 'e3db1999d5ce0744f02eb7f48273ddfc473562961a7a5010b5e87ae8121dc5ec'
  })

  depends_on 'glibc' => :executable

  autotools_configure_options "--enable-mt #{'--disable-year2038' unless ARCH.eql?('x86_64')}"

  def self.patch
    system './bootstrap'
    # The aclocal version is hardcoded.
    aclocal_version = `aclocal --version|head -1|cut -d' ' -f4`.chomp.gsub(/\.\d+$/, '')
    system "sed -i 's,1.16,#{aclocal_version},g' configure"
  end

  autotools_install_extras do
    # Remove conflicts with tar package.
    FileUtils.rm_f "#{CREW_DEST_PREFIX}/libexec/rmt"
    FileUtils.rm_f "#{CREW_DEST_MAN_PREFIX}/man8/rmt.8"
  end
end
