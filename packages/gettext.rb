require 'package'

class Gettext < Package
  version '0.18.3.1'
  binary_url ({
    armv7l: 'https://dl.dropboxusercontent.com/s/wmfctz7x8bj6cwe/gettext-0.18.3.1-chromeos-armv7l.tar.xz',
    i686: 'https://dl.dropboxusercontent.com/s/xmsfr7q9r99dhcs/gettext-0.18.3.1-chromeos-i686.tar.gz?token_hash=AAGJo0pqudCOkGU3NHOcBuFG2zLwWpapNXLX-zUJLcS3aA&dl=1',
    x86_64: 'https://dl.dropboxusercontent.com/s/nidj0ehxwserhz6/gettext-0.18.3.1-chromeos-x86_64.tar.gz?token_hash=AAFn-kdXlB23HDVDCKTn9n_U-i9LFNCIB6HU0jSUiJTctA&dl=1'
  })
  binary_sha1 ({
    armv7l: '5224004048dd80bb523cd0091ad577b21448790b',
    i686: '1ecbff59d6134c7f8804bcf18fb2b1b7a9a6d4c0',
    x86_64: '22174347defa4f034a360078c248a61710c5f854'
  })
end
