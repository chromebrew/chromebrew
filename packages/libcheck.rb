require 'package'

class Libcheck < Package
  description 'A unit testing framework for C'
  homepage 'https://github.com/libcheck/check'
  version '0.13.0'
  source_url 'https://github.com/libcheck/check/archive/0.13.0.tar.gz'
  source_sha256 'c95d5e0419f768c100ec6d91c7b0a05985f07cc05b93c3c68c3efd48d3655fce'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system 'autoreconf --install'
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
