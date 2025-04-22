require 'package'

class Lowdown < Package
  description 'Simple markdown translator'
  homepage 'https://kristaps.bsd.lv/lowdown'
  version '1.4.0'
  license 'ISC'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/kristapsdz/lowdown.git'
  git_hashtag "VERSION_#{version.gsub('.', '_')}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '69af2c86e0e24dfaa47073714445c037944caa11fea828bb34fd5b0184da2007',
     armv7l: '69af2c86e0e24dfaa47073714445c037944caa11fea828bb34fd5b0184da2007',
     x86_64: '62a800d9f0895e4245a8cbe010f2e250f861610828cc0f60d959d16e950d61b2'
  })

  depends_on 'glibc' # R

  def self.build
    system './configure'
    # These constants need set inside Makefile
    system "sed -i '17iPREFIX = #{CREW_PREFIX}' Makefile"
    system "sed -i '18iLIBDIR = #{CREW_LIB_PREFIX}' Makefile"
    system 'make'
    system 'make regress'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} make install install_libs"
  end
end
