require "package"

class Ascii < Package
  description 'List ASCII idiomatic names and octal/decimal code-point forms.'
  homepage 'http://www.catb.org/~esr/ascii/'
  version "3.15"
  source_url "http://www.catb.org/~esr/ascii/ascii-3.15.tar.gz"
  source_sha1 "94ac41d8ef89daf148ebfd30333c07f6e64d4dec"

  def self.build
    system "make"
  end

  def self.install
    system "mkdir -p #{CREW_DEST_DIR}/usr/local/bin"
    system "cp ascii #{CREW_DEST_DIR}/usr/local/bin"
  end
end

