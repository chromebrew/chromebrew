require 'package'

class Linuxheaders < Package
  version '3.4.0'
  binary_url ({
    armv7l: "https://dl.dropboxusercontent.com/s/kut6emhlda9pbc9/dummy-1.0.0-chromeos-armv7l.tar.gz",
    i686: "https://dl.dropboxusercontent.com/s/mdzdoyq7dtnz682/linux-headers-3.4.0-chromeos-i686.tar.gz?token_hash=AAE4yw5oH_SfZ3lAx02mFP603rnjmoB9Gp4vqTY14NsA-A&dl=1",
    x86_64: "https://dl.dropboxusercontent.com/s/3ec3fjpls0t2iqn/linuxheaders-3.8.11-chromeos-x86_64.tar.gz?token_hash=AAFl1_1I3FtwGdoGvGJuGrGUqzaDkhumPzsGJMX5pYhZyQ&dl=1"
  })
  binary_sha1 ({
    armv7l: "049db60338a74d798e72afabe05097f3a4c4f7cd",
    i686: "31c933f3a4e82fd9310b0f5b32d79c9a51514fee",
    x86_64: "c113e16d72147429f774ba6678d72a221b19a5bc"
  })
end
