require 'package'

class Expat < Package
  version '2.1.0'
  binary_url ({
    i686: 'https://dl.dropboxusercontent.com/s/jh5uw42elm40t9a/expat-2.1.0-chromeos-i686.tar.gz?token_hash=AAGYckE0KoTPsydZGG85KTkpr7Nt5U1OUs0egJ1K0iJ1mg&dl=1',
    x86_64: 'https://dl.dropboxusercontent.com/s/k89o1x1a3fwoamu/expat-2.1.0-chromeos-x86_64.tar.gz?token_hash=AAGBLOil45Zg7G2RlFlfDUxKfeDyTP3uUWjfBvGQrOjAYA&dl=1',
    armv7l: 'https://www.dropbox.com/s/5q7e2dcxyecklwe/expat-2.0.1-armv7l.tar.gz?dl=0'
  })
  binary_sha1 ({
    i686: '9ab42ec03d06cc64d5d9944cb4cc7eaa61a0af84',
    x86_64: '3ac96a0e02c1117718d15bcd4976ef4bcef1a9ac',
    armv7l: 'cebddf566cdb808c50813b37550b3438693389f4'
  })
end
