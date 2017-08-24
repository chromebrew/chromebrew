require 'package'

class Utf8proc < Package
  description 'a clean C library for processing UTF-8 Unicode data: normalization, case-folding, graphemes, and more'
  homepage 'https://julialang.org/utf8proc/'
  version '2.1.0'
  source_url 'https://github.com/JuliaLang/utf8proc/archive/v2.1.0.tar.gz'
  source_sha256 '25ccc5619ac400f9eaf24aafaae5b625afa1961e140b8dd6072b393267833260'

  def self.build
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
