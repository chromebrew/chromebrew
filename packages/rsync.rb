require 'package'

class Rsync < Package
  description 'rsync is an open source utility that provides fast incremental file transfer.'
  homepage 'https://rsync.samba.org/'
  version '3.2.5'
  license 'GPL-3'
  compatibility 'all'
  source_url "http://rsync.samba.org/ftp/rsync/src/rsync-#{@_ver}.tar.gz"
  source_sha256 '2ac4d21635cdf791867bc377c35ca6dda7f50d919a58be45057fd51600c69aba'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/rsync/3.2.5_armv7l/rsync-3.2.5-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/rsync/3.2.5_armv7l/rsync-3.2.5-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/rsync/3.2.5_i686/rsync-3.2.5-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/rsync/3.2.5_x86_64/rsync-3.2.5-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'a2b1a6ed4614b1fd9bb41914669bb30783d70ad5719c13760ed0fbce9be0aae3',
     armv7l: 'a2b1a6ed4614b1fd9bb41914669bb30783d70ad5719c13760ed0fbce9be0aae3',
       i686: 'f026e547aeeb952b75df5e710f64e6cb54a7ad6a845f3443dc601d93b1bed31e',
     x86_64: '02db82ac18ab11be2e081cb1c909d93694eeb78e7b5d198287b1b872095912c0'
  })

  depends_on 'acl' # R
  depends_on 'attr' # R
  depends_on 'glibc' # R
  depends_on 'lz4' # R
  depends_on 'openssl' # R
  depends_on 'popt' # R
  depends_on 'py3_cmarkgfm' => :build
  depends_on 'xxhash' # R
  depends_on 'zstd' # R
  no_patchelf
  no_zstd

  def self.build
    system "./configure #{CREW_OPTIONS} --disable-maintainer-mode"
    system 'make'
  end

  def self.check
    system 'make check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
