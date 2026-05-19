require 'package'

class Uasm < Package
  description 'A MASM-compatible assembler'
  homepage 'http://www.terraspace.co.uk/uasm.html'
  version '2.57'
  license 'JWasm'
  compatibility 'all'
  source_url 'https://github.com/Terraspace/UASM.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2c49710bfd224e09b27de1b9cf6ff92fd352e96c10ff3f54ed20a9e381d51c19',
     armv7l: '2c49710bfd224e09b27de1b9cf6ff92fd352e96c10ff3f54ed20a9e381d51c19',
       i686: '9cf96de8d48d186d0ee76df01fa53f3d0e271e6d7edefc76dbd3e60819bd6fc2',
     x86_64: '3e508527a193179c479fac56d964060b0b6333916cc99b88e6f5cc1fbab1f20a'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable

  ignore_updater # versioning for uasm seems to randomly add suffixes.

  def self.patch
    patches = [
      # Build fixes
      ['https://patch-diff.githubusercontent.com/raw/Terraspace/UASM/pull/216.diff', '679690c51900bf88dce862c93bf36db7b761afcc18d54d3f97b076fc86da3f66'],
      # Fix for CVE-2017-16516
      ['https://gitlab.archlinux.org/archlinux/packaging/packages/uasm/-/raw/main/add-missing-header.patch?ref_type=heads&inline=false', '4840e477c46c708b4d46c99317d5ef7985284ed5a5ff42bd014118d3dee996a1']
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
