require 'package'

class Glibc < Package
  version '2.19'
  binary_url ({
    armv7l: "https://dl.dropboxusercontent.com/s/mtql9jcvct11tsi/glibc-2.19-chromeos-armv7l.tar.xz",
    i686: "https://dl.dropboxusercontent.com/s/fr8msjl41euauyp/glibc-2.19-chromeos-i686.tar.xz",
    x86_64: "https://dl.dropboxusercontent.com/s/ow8hg6zuww1n7s2/glibc-2.19-chromeos-x86_64.tar.xz",
  })
  binary_sha1 ({
    armv7l: "c4da258eacf411833494bbe6903918909fb5629c",
    i686: "7d7f4e8e137bbb96dea2b2792dc12a7e61c729d9",
    x86_64: "073545bf8aa4b29fbf9084d31848b40f1df1b4ef",
  })
end
