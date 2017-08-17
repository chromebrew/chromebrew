require 'package'

class Jq < Package
  description 'jq is a lightweight and flexible command-line JSON processor.'
  homepage 'https://stedolan.github.io/jq/'
  version '1.5'
  source_url 'https://github.com/stedolan/jq/releases/download/jq-1.5/jq-1.5.tar.gz'
  source_sha256 'c4d2bfec6436341113419debf479d833692cc5cdab7eb0326b5a4d4fbe9f493c'

  def self.build
    system "./configure",
      "--prefix=/usr/local",
      "--disable-maintainer-mode", # disable make rules and dependencies not useful
      "--disable-docs"             # there's no support for manpages
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
