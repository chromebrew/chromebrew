require 'package'

class Node < Package
  description 'As an asynchronous event driven JavaScript runtime, Node is designed to build scalable network applications.'
  homepage 'https://nodejs.org/en/'
  version '8.9.1'
  compatibility 'all'

  is_fake

  depends_on 'nodebrew'
end
