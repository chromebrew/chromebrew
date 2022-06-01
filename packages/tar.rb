require 'package'

class Tar < Package
  description 'GNU Tar provides the ability to create tar archives, as well as various other kinds of manipulation.'
  homepage 'https://www.gnu.org/software/tar/'
  version '1.34-1'
  license 'BSD'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/gnu/tar/tar-1.34.tar.xz'
  source_sha256 '63bebd26879c5e1eea4352f0d03c991f966aeb3ddeb3c7445c902568d5411d28'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tar/1.34-1_armv7l/tar-1.34-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tar/1.34-1_armv7l/tar-1.34-1-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tar/1.34-1_i686/tar-1.34-1-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tar/1.34-1_x86_64/tar-1.34-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'aac20805fa2ea1680117b88966a7809968eaf3cc76723d2c214a4bdbf12b778f',
     armv7l: 'aac20805fa2ea1680117b88966a7809968eaf3cc76723d2c214a4bdbf12b778f',
       i686: '83729fed6d5cbc0599a6bcd8b94b6b527f8dabb77d97051cb4b8494757f870ff',
     x86_64: '1644c4e2725d8965c3b735ab1f0ac67afd9c0891d6942ca187cf3f80d27a5bad'
  })

  depends_on 'musl_native_toolchain' => :build
  depends_on 'musl_zstd' => :build
  depends_on 'musl_xz' => :build

  is_musl
  is_static
  no_zstd

  def self.build
    system "#{MUSL_ENV_OPTIONS} ./configure \
      --prefix=#{CREW_MUSL_PREFIX} \
      --libdir=#{CREW_MUSL_PREFIX}/lib \
      --mandir=#{CREW_PREFIX}/share/man \
      --with-lzma=xz"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    # Simplying the following block leads to the symlink not being created properly.
    Dir.chdir "#{CREW_DEST_PREFIX}/bin" do
      FileUtils.ln_s '../share/musl/bin/tar', 'tar'
    end
  end

  def self.check
    system 'make', 'check'
  end
end
