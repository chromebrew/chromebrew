require 'package'

class Jq < Package
  description 'jq is a lightweight and flexible command-line JSON processor.'
  homepage 'https://stedolan.github.io/jq/'
  version '1.5'
  source_url 'https://github.com/stedolan/jq/releases/download/jq-1.5/jq-1.5.tar.gz'
  source_sha256 'c4d2bfec6436341113419debf479d833692cc5cdab7eb0326b5a4d4fbe9f493c'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/jq-1.5-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/jq-1.5-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/jq-1.5-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/jq-1.5-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'd5398f27fdf82f4292163d129086dfabd7ce49396e5a4c2c548403717b6c2888',
     armv7l: 'd5398f27fdf82f4292163d129086dfabd7ce49396e5a4c2c548403717b6c2888',
       i686: '92b22b3217e06115930d51866dd01c9a7f8ef2bb2135ff7d9ecbe776486057fd',
     x86_64: 'eaddfe1fd38c4d93a9c5b7ecf8bd1cd75a1c8e00e8230696c29dab50726068bb',
  })

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
