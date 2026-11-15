require 'package'

class Uasm < Package
  description 'A MASM-compatible assembler'
  homepage 'http://www.terraspace.co.uk/uasm.html'
  version '2.57r'
  license 'JWasm'
  compatibility 'all'
  source_url 'https://github.com/Terraspace/UASM.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '34d98e2523fe50a501d0ef88f90c7f8b18a8c6a4bcc3c37abd0dae1efd4d007e',
     armv7l: '34d98e2523fe50a501d0ef88f90c7f8b18a8c6a4bcc3c37abd0dae1efd4d007e',
       i686: '3c4a7bf95a300a8335a1f1eeed02f5f29e8941b0ea38f109907436d908f36c48',
     x86_64: '18cc14cafc7d9a7f85ce50d5bf4b995db5c1b731e2d560357cba5fd7e305e0ac'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable

  ignore_updater # versioning for uasm seems to randomly add suffixes.

  def self.patch
    patches = [
      [
        # Build fixes
        'https://patch-diff.githubusercontent.com/raw/Terraspace/UASM/pull/216.diff',
        '679690c51900bf88dce862c93bf36db7b761afcc18d54d3f97b076fc86da3f66'
      ],
      [
        # Fix for CVE-2017-16516
        'https://gitlab.archlinux.org/archlinux/packaging/packages/uasm/-/raw/main/add-missing-header.patch?ref_type=heads&inline=false',
        '4840e477c46c708b4d46c99317d5ef7985284ed5a5ff42bd014118d3dee996a1'
      ]
    ]
    ConvenienceFunctions.patch(patches)
  end

  def self.build
    # See: https://stackoverflow.com/a/46223160
    # -D_XOPEN_SOURCE=700 is needed to handle a
    # implicit declaration of function ‘fileno’ error.
    system "CFLAGS='-std=c17 -D_XOPEN_SOURCE=700' make -f Makefile-Linux.mak"
  end

  def self.install
    FileUtils.install 'GccUnixR/uasm', "#{CREW_DEST_PREFIX}/bin/", mode: 0o755
  end
end
