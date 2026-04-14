require 'package'

class Mpreal < Package
  description 'Thin wrapper for MPFR'
  homepage 'https://github.com/advanpix/mpreal'
  version '3.7.2'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://github.com/advanpix/mpreal.git'
  git_hashtag "mpfrc++-#{version}"

  depends_on 'mpfr' => :library

  no_compile_needed

  def self.install
    FileUtils.install 'mpreal.h', "#{CREW_DEST_PREFIX}/include/mpreal.h", mode: 0o644
  end
end
