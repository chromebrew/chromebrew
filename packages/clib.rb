require 'buildsystems/autotools'

class Clib < Autotools
  description 'C package manager-ish'
  homepage 'https://github.com/clibs/clib'
  version '2.8.7'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/clibs/clib.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e012bd99c11f7c1d8bbfca3143dbe8431cde6dec12772fb05691bfca1d3d5f72',
     armv7l: 'e012bd99c11f7c1d8bbfca3143dbe8431cde6dec12772fb05691bfca1d3d5f72',
       i686: '3b97511ce7043ead923a635b150b596dc5582e4e4cc37c27a3bf64734b661bcd',
     x86_64: '341c4cafa4ba4f4f43532da8c507735511fafbedc38a45a88b058a58d84a062b'
  })

  depends_on 'curl' => :executable
  depends_on 'glibc' => :executable

  def self.patch
    system "sed -i 's,PREFIX ?= /usr/local,PREFIX ?= #{CREW_DEST_PREFIX},' Makefile"
  end

  autotools_skip_configure

  autotools_install_extras do
    FileUtils.ln_s "#{CREW_PREFIX}/bin/clib", "#{CREW_DEST_PREFIX}/bin/cpm"
  end
end
