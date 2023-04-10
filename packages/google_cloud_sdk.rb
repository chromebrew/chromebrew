require 'package'
require_relative 'gcloud'

class Google_cloud_sdk < Package
  description Gcloud.description.to_s
  homepage Gcloud.homepage.to_s
  version Gcloud.version.to_s
  license Gcloud.license.to_s
  compatibility Gcloud.compatibility.to_s

  is_fake

  depends_on 'gcloud'
end
