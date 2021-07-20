require 'package'

class Jq < Package
  description 'jq is a lightweight and flexible command-line JSON processor.'
  homepage 'https://stedolan.github.io/jq/'
  @_ver = '1.6'
  version "#{@_ver}-2"
  license 'MIT and CC-BY-3.0'
  compatibility 'all'
  source_url 'https://github.com/stedolan/jq.git'
  git_hashtag "jq-#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/jq/1.6-2_armv7l/jq-1.6-2-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/jq/1.6-2_armv7l/jq-1.6-2-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/jq/1.6-2_i686/jq-1.6-2-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/jq/1.6-2_x86_64/jq-1.6-2-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '3d7e313a1bdaa9c2d0ab3ede26b93a6932b3a0f21bfebc282f581a8804451767',
     armv7l: '3d7e313a1bdaa9c2d0ab3ede26b93a6932b3a0f21bfebc282f581a8804451767',
       i686: 'f11443b8744ce0c38fe9b8430337fd9ba3412fddeb8b343764dc50825c42d806',
     x86_64: 'c1af7fdb7fee27472773863ca97db802a39363b7a0b9a4866ed93d8fc6cbb528'
  })

  def self.build
    system '[ -x configure ] || autoreconf -fvi'
    system 'filefix'
    system "CC=clang LD=ld.lld  CFLAGS='-flto -pipe -O3 -fuse-ld=lld -static' \
      CXXFLAGS='-flto -pipe -O3 -static' \
      LDFLAGS='-flto -static' \
      ./configure \
      --prefix=#{CREW_PREFIX} \
      --libdir=#{CREW_LIB_PREFIX} \
      --mandir=#{CREW_MAN_PREFIX} \
      --enable-all-static \
      --disable-maintainer-mode \
      --disable-docs " # there's no support for manpages
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
